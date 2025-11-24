#!/bin/bash
helm repo add metallb https://metallb.github.io/metallb
helm install metallb metallb/metallb --wait --wait-for-jobs --namespace cluster-system

# Apply the metallb configuration
kubectl apply -f metallb/metallb-config.yaml -n cluster-system
