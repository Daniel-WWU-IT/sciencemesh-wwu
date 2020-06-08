#!/bin/bash
helm delete prometheus
kubectl delete -f k8s/prom-shared-data-pvc.yaml
