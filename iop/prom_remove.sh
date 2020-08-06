#!/bin/bash
helm delete prometheus
# Uncomment to delete the PVC
# kubectl delete -f k8s/prom-shared-data-pvc.yaml
