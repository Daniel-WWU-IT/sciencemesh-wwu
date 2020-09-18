#!/bin/bash
helm install blackbox-exporter prometheus-community/prometheus-blackbox-exporter -f charts/blackbox-exporter.yaml
