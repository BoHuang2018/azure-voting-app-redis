#!/bin/bash



cluster_name="simpleApp"
resource_group_name="coop-interview-staging"
FILE="azure-vote-all-in-one-redis.yaml"

az aks get-credentials --name "$cluster_name" --resource-group "$resource_group_name"
kubectl apply -f "$FILE"