#!/bin/bash

# --- Configuration ---
# The input file containing the placeholder
CONFIG_FILE="cert-manager/production-issuer.yaml"
SECRET_CONFIG_FILE="cert-manager/secret.yaml"

# A practical regex for email validation.
# Note: Perfect email validation (RFC 5322) is extremely complex.
# This regex checks for a common 'user@domain.tld' structure.
EMAIL_REGEX="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"

# The placeholder string to be replaced
EMAIL_PLACEHOLDER="<YOUR_EMAIL_HERE>"
API_PLACEHOLDER="<INSERT-YOUR-API-TOKEN>"

# 1. Check if the input file exists
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Error: Configuration file '$CONFIG_FILE' not found." >&2
  echo "Please create it first with the YAML content." >&2
  exit 1
fi

# 2. Prompt the user for their email and api_token
# Follow this documentation to create a api_token with the proper permissions: https://cert-manager.io/docs/configuration/acme/dns01/cloudflare/
read -p "Enter your email address: " user_email
read -s -p "Enter your API Token: " api_token

# 3. Validate the email format
if [[ $user_email =~ $EMAIL_REGEX ]]; then
  echo "✅ Email format appears valid."
  echo ""
  echo "--- Applying changes to $CONFIG_FILE ---"
  echo "--- Applying changes to $SECRET_CONFIG_FILE ---"

  # 4. Use sed to perform the replacement and print to standard output
  #
  # Explanation:
  #   -s ...          : The substitution command.
  #   #               : We use '#' as the delimiter instead of the usual '/'
  #                   to prevent errors if the email address contains a slash.
  #   $PLACEHOLDER    : The string to find.
  #   $user_email     : The replacement string.
  #   #g              : The 'g' flag ensures *all* instances are replaced,
  #                   not just the first one on each line.
  #   "$CONFIG_FILE"  : The input file.

  sed -i "s#$EMAIL_PLACEHOLDER#$user_email#g" "$CONFIG_FILE"
  sed -i "s#$API_PLACEHOLDER#$api_token#g" "$SECRET_CONFIG_FILE"

  echo "----------------------------------------"
  echo "Done."

else
  echo "❌ Error: Invalid email format." >&2
  echo "No changes were made." >&2
  exit 1
fi

helm repo add jetstack https://charts.jetstack.io --force-update

# Make sure you edit your secret
kubectl apply -f cert-manager/secret.yaml

helm upgrade cert-manager jetstack/cert-manager -n cluster-system -f cert-manager/cert-manager-values.yaml --wait --wait-for-jobs -i

kubectl apply -f cert-manager/testing-issuer.yaml -n cluster-system
kubectl apply -f cert-manager/production-issuer.yaml -n cluster-system
