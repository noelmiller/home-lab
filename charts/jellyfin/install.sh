#!/bin/bash

kubectl apply -f namespace.yaml -n media-services
helm repo add jellyfin https://jellyfin.github.io/jellyfin-helm
helm upgrade --install jellyfin jellyfin/jellyfin -f values.yaml --namespace media-services

kubectl apply -f route.yaml -n media-services