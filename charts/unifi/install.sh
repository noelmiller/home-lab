#!/bin/bash

kubectl apply -f namespace.yaml -n unifi
helm upgrade --install unifi oci://ghcr.io/mkilchhofer/unifi-chart/unifi \
  --values values.yaml \
  --namespace unifi \
  --wait

kubectl apply -f unifi-gateway.yaml -n unifi

kubectl apply -f unifi-route.yaml -n unifi

kubectl apply -f unifi-backend.yaml -n unifi

kubectl apply -f unifi-proxy.yaml -n unifi