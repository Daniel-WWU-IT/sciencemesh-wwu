#!/bin/bash
kubectl apply -f k8s/prom-shared-data-pvc.yaml
helm install prometheus prometheus-community/prometheus \
    --set-file extraScrapeConfigs=config/prometheus.yaml \
    -f charts/prometheus.yaml
