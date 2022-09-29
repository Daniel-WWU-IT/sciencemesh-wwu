#!/bin/bash
kubectl apply -f k8s/gocdb-data-pvc.yaml
helm install gocdb ../../gocdb/charts/gocdb \
    --set-file database.data=config/gocdb/gocdb-data.sql \
    -f charts/gocdb.yaml
