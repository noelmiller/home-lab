#!/bin/bash
export KUBECONFIG=~/.kube/k3s.yaml
## 1. Create internal namespace
kubectl apply -f namespace.yaml

## 2. Configure local-storage
local-storage/install.sh

## 3. Install metrics-server
metrics-server/install.sh

## 4. Install jetstack cert-manager, cloudflare dns01
cert-manager/install.sh

## 5. Install ingress-nginx
ingress-nginx/install.sh

## May add in the future..
## 6. Install kubernetes dashboard
# k8s-dashboard/install.sh

## WIP: argocd
## 7. Install argocd
# argocd/install.sh
