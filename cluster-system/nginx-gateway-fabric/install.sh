#!/bin/bash
helm install ngf oci://ghcr.io/nginx/charts/nginx-gateway-fabric -n cluster-system
