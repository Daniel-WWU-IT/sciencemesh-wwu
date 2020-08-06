#!/bin/bash
helm delete iop
# Uncomment to delete the PVC
# kubectl delete -f k8s/iop-data-pvc.yaml
