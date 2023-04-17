#!/bin/bash
kubectl delete secret sciencemesh-tls
# Chain consists of Server cert + Chain + Root
# PEM file: First part (up to ~L53) = key; Remaining stuff = cert
kubectl create secret tls sciencemesh-tls --cert=sciencemesh.cert --key=sciencemesh.key
