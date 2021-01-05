#!/bin/bash
helm install grafana grafana/grafana \
    --set-file dashboards.sciencemesh.general-statistics.json=config/grafana/general-statistics.json \
    --set-file dashboards.sciencemesh.health-monitoring.json=config/grafana/health-monitoring.json \
    -f charts/grafana.yaml
