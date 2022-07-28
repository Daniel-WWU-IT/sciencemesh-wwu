#!/bin/bash
helm upgrade gocdb ../../gocdb/charts/gocdb \
    --set-file database.data=config/gocdb/gocdb-data.sql \
    -f charts/gocdb.yaml
