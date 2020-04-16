#!/bin/bash

#namespace=${1:-deephealth_backend}
namespace=${1:-dhb}

helm upgrade \
    --install --debug \
    --namespace ${namespace} \
    dhf  \
    deephealth-frontend \
    --recreate-pods \
    -f values.yaml 
