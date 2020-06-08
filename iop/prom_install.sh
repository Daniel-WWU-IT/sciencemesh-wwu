#!/bin/bash
kubectl apply -f k8s/prom-shared-data-pvc.yaml
helm install prometheus stable/prometheus -f charts/prometheus.yaml
