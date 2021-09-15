#!/bin/bash
# Merge the chart's values file and the rules configurations into one; this allows the rules configurations to be kept in separate files
cp charts/prometheus.yaml charts/prometheus.merged.yaml
cp config/prometheus/rec_rules.yaml config/prometheus/rec_rules.merged.yaml
cp config/prometheus/alert_rules.yaml config/prometheus/alert_rules.merged.yaml

sed -i -e 's/^/    /' config/prometheus/rec_rules.merged.yaml
sed -i -e '/REC_RULES/r config/prometheus/rec_rules.merged.yaml' charts/prometheus.merged.yaml
sed -i -e 's/^/    /' config/prometheus/alert_rules.merged.yaml
sed -i -e '/ALERT_RULES/r config/prometheus/alert_rules.merged.yaml' charts/prometheus.merged.yaml

kubectl apply -f k8s/prom-shared-data-pvc.yaml
helm upgrade prometheus prometheus-community/prometheus \
    --set-file extraScrapeConfigs=config/prometheus/prometheus.yaml \
    -f charts/prometheus.merged.yaml

rm -f charts/prometheus.merged.yaml
rm -f config/prometheus/rec_rules.merged.yaml
rm -f config/prometheus/alert_rules.merged.yaml
