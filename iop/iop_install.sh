#!/bin/bash
kubectl apply -f k8s/mentix-data-pvc.yaml
kubectl apply -f k8s/iop-data-pvc.yaml
helm install iop sciencemesh/iop \
    --set-file gateway.configFiles.revad\\.toml=config/iop/gateway.toml \
    --set-file gateway.configFiles.users\\.json=config/iop/users.json \
    --set-file storageprovider-home.configFiles.revad\\.toml=config/iop/storage-home.toml \
    --set-file storageprovider-reva.configFiles.revad\\.toml=config/iop/storage-reva.toml \
    -f charts/iop.yaml
