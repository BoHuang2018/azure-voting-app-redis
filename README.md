---
page_type: sample
languages:
  - python
products:
  - azure
  - azure-redis-cache
description: "This sample creates a multi-container application in an Azure Kubernetes Service (AKS) cluster."
---

# Coop Fish Voting App

We use this repo as a sample to present that a terraform-managed infrastructure (AKS, Azure Container Registry ...) can be 
object of deployment container images.

The Azure infrastructure is managed by another repository consisted of Terraform scripts mainly. All required environmental variables 
are rooted from that terraform repository.

We will go through a path like: local test --> deploy to staging --> deploy to prod.

## 1. Local Test
To build an image of the app and run it locally (if we need a new version tag, change the value of `version` in `Makefile`):
```commandline
make local-image-test
```
The running app will be visible on `http://localhost:8080`. 
To turn off the running app, we use `docker compose down` to stop the app and remove the containers.
But the created images are still there, `docker images` will show it
```commandline
REPOSITORY                                               TAG                        IMAGE ID      
mcr.microsoft.com/azuredocs/azure-vote-front             v2                         8cd22ff578ea  
```

## 2. Push Image to Azure Container Registry
### 2.1 Staging
