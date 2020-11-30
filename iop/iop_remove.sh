#!/bin/bash
helm delete iop
# Uncomment to delete the PVCs
# kubectl delete -f k8s/iop-data-pvc.yaml
# kubectl delete -f k8s/mentix-data-pvc.yaml
