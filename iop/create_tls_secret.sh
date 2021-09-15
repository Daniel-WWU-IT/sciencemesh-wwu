#!/bin/bash
kubectl delete secret sciencemesh-tls
# Chain consists of Server cert + Chain + Root
kubectl create secret tls sciencemesh-tls --cert=sciencemesh-chain.cert --key=sciencemesh.key

