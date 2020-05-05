#!/usr/bin/bash
export TARGET=/home/tak/proj/sciencemesh/gocdb-container
mkdir -p $TARGET

rsync -avE --delete --delete-excluded --exclude-from=copy-files.ignore ./ $TARGET
