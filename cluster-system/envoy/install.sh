#!/bin/bash
helm upgrade --install eg oci://docker.io/envoyproxy/gateway-helm \
  --version v1.6.0 \
  --namespace envoy-gateway-system \
  --create-namespace \
  --set config.envoyGateway.extensionApis.enableBackend=true \
  --wait
