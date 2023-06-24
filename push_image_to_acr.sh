#!/bin/bash

version='v2'
app_name='azure-vote-front'

# Log in to the container registry staging
az acr login --name "$AZURE_ARC_LOGIN_SERVER_STAGING"

# Tag the local azure-vote-front image with the arcLoginServer address
docker tag mcr.microsoft.com/azuredocs/"$app_name":"$version" "$AZURE_ARC_LOGIN_SERVER_STAGING"/"$app_name":"$version"

# Push images to registry
docker push "$AZURE_ARC_LOGIN_SERVER_STAGING"/"$app_name":"$version"
