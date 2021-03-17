#!/bin/bash
# Merge the chart's values file and the BBE configuration into one; this allows the BBE configuration to be kept in a separate file
cp charts/blackbox-exporter.yaml charts/blackbox-exporter.merged.yaml
cp config/bbe/blackbox-exporter.yaml config/bbe/blackbox-exporter.merged.yaml

sed -i -e 's/^/  /' config/bbe/blackbox-exporter.merged.yaml
sed -i -e '/MODULES/r config/bbe/blackbox-exporter.merged.yaml' charts/blackbox-exporter.merged.yaml

helm upgrade blackbox-exporter prometheus-community/prometheus-blackbox-exporter \
    -f charts/blackbox-exporter.merged.yaml

rm -f charts/blackbox-exporter.merged.yaml
rm -f config/bbe/blackbox-exporter.merged.yaml
