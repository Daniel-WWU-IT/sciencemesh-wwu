#!/bin/bash
helm upgrade prometheus-alertmanager prometheus-community/alertmanager -f charts/alertmanager.yaml
