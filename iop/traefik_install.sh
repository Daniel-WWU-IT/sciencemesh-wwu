#!/bin/bash
kubectl apply -f ingress/traefik.yaml
kubectl apply -f ingress/ingress.yaml
