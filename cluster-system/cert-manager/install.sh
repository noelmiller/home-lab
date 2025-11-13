#!/bin/bash

helm repo add jetstack https://charts.jetstack.io --force-update

# Make sure you edit your secret
kubectl apply -f cert-manager/secret.yaml

helm upgrade cert-manager jetstack/cert-manager -n cluster-system -f cert-manager/cert-manager-values.yaml --wait --wait-for-jobs -i

kubectl apply -f cert-manager/testing-issuer.yaml -n cluster-system
kubectl apply -f cert-manager/production-issuer.yaml -n cluster-system
