#!/bin/bash
helm install prometheus-alertmanager prometheus-community/alertmanager -f charts/alertmanager.yaml
