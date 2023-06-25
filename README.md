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

## 0. Use Environmental Variables
All below commands use environmental variables. We need to place a `.env` file in the root path of this repo and 
run `source .env` before we do anything.

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
There are two instances of Azure Container Registry (staging and prod). We can push the newly built image to Azure Container Registry.
### 2.1 Staging
```commandline
make push_to_acr_staging
```
This commend involves another commend to login to the correct Azure Container Registry.

### 2.2 Prod
Wait for infrastructure


## 3. Deploy to AKS
There are two instances of AKS (staging and prod). We will deploy 
1. Docker image managed by Azure Container Registry in staging to AKS in staging.
2. Docker image managed by Azure Container Registry in production to AKS in production.

### 3.1 Staging
```commandline
make make deploy_to_aks_staging
```
The deployment comment 
The first time's deployment may take a few moment. We can verify the deployment by
```commandline
kubectl get serives
```
The returning would looks like
```commandline
NAME               TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)        AGE
azure-vote-back    ClusterIP      10.0.213.77   <none>          6379/TCP       25h
azure-vote-front   LoadBalancer   10.0.1.54     xx.xxx.xx.xxx   80:30111/TCP   25h
kubernetes         ClusterIP      10.0.0.1      <none>          443/TCP        25h
```
Use a browser to open the EXTERNAL-IP. The app works same as the one on 'http://localhost:8080'. But it is hosted by AKS.

### 3.2 Prod
Wait for infrastructure
