#!/bin/bash
kubectl delete -f ingress/ingress-phoenix.yaml
kubectl delete -f ingress/traefik.yaml
