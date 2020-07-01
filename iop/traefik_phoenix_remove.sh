#!/bin/bash
kubectl delete -f ingress/ingress.yaml
kubectl delete -f ingress/traefik.yaml
