#!/bin/bash
# Merge the chart's values file and the BBE configuration into one; this allows the BBE configuration to be kept in a separate file
cat charts/blackbox-exporter.yaml > charts/blackbox-exporter.merged.yaml
cat config/blackbox-exporter.yaml | sed -e 's/^/  /' >> charts/blackbox-exporter.merged.yaml

helm install blackbox-exporter prometheus-community/prometheus-blackbox-exporter -f charts/blackbox-exporter.merged.yaml

rm -f charts/blackbox-exporter.merged.yaml
