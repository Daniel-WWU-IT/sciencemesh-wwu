#!/bin/bash
kubectl apply -f k8s/iop-data-pvc.yaml
helm install iop sciencemesh/iop \
    --set-file gateway.configFiles.revad\\.toml=config/gateway.toml \
    --set-file gateway.configFiles.users\\.json=config/users.json \
    --set-file storageprovider-home.configFiles.revad\\.toml=config/storage-home.toml \
    --set-file storageprovider-reva.configFiles.revad\\.toml=config/storage-reva.toml \
    -f charts/iop.yaml
