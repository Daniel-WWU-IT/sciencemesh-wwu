#!/bin/bash
kubectl apply -f k8s/prom-shared-data-pvc.yaml
helm install prometheus prometheus-community/prometheus -f charts/prometheus.yaml
