#!/bin/bash
helm install grafana grafana/grafana \
    --set-file dashboards.sciencemesh.general-statistics.json=config/grafana/general-statistics.json \
    --set-file dashboards.sciencemesh-health.health-monitoring.json=config/grafana/health-monitoring.json \
    --set-file dashboards.sciencemesh-health.check-history.json=config/grafana/check-history.json \
    -f charts/grafana.yaml
