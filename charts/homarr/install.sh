#!/bin/bash
kubectl apply -f namespace.yaml -n dashboard
kubectl apply -f secret.yaml -n dashboard
helm repo add homarr-labs https://homarr-labs.github.io/charts/
helm repo update
helm upgrade --install homarr homarr-labs/homarr -f values.yaml --namespace dashboard
