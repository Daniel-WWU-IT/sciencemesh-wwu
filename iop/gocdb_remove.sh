#!/bin/bash
helm delete gocdb
kubectl delete pvc data-gocdb-database-0
