#!/bin/bash
helm delete gocdb
# Uncomment to delete the PVCs
# kubectl delete -f k8s/gocdb-data-pvc.yaml
