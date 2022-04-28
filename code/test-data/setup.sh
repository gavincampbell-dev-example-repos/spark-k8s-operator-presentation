#!/usr/bin/env bash

# depends on minio client tool https://docs.min.io/docs/minio-client-complete-guide.html with an alias name 'minio'



mc mb --ignore-existing minio/staging
mc mb --ignore-existing minio/output
mc mb --ignore-existing minio/code

mc cp ./kebabsales.json minio/staging
mc cp ../example.py minio/code
mc cp ../example_with_dependency.py minio/code
