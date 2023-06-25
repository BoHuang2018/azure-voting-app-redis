version='v2'
app_name='azure-vote-front'
deployment_file_staging='azure-vote-all-in-one-redis-staging.yaml'
deployment_file_prod='azure-vote-all-in-one-redis-prod.yaml'

.PHONY: local-image-test
local-image-test:
	docker compose up -d

.PHONY: login_acr_staging
login_acr_staging:
	az acr login --name ${AZURE_ARC_LOGIN_SERVER_STAGING}

.PHONY: login_acr_prod
login_acr_prod:
	az acr login --name ${AZURE_ARC_LOGIN_SERVER_PROD}

.PHONY: push_to_acr_staging
push_to_acr_staging: login_acr_staging
	# Tag the local azure-vote-front image with the arcLoginServer address
	docker tag mcr.microsoft.com/azuredocs/$(app_name):$(version) ${AZURE_ARC_LOGIN_SERVER_STAGING}/${app_name}:$(version)
	# Push images to registry
	docker push ${AZURE_ARC_LOGIN_SERVER_STAGING}/$(app_name):$(version)

.PHONY: push_to_acr_prod
push_to_acr_prod: login_acr_prod
	# Tag the local azure-vote-front image with the arcLoginServer address
	docker tag mcr.microsoft.com/azuredocs/$(app_name):$(version) ${AZURE_ARC_LOGIN_SERVER_PROD}/${app_name}:$(version)
	# Push images to registry
	docker push ${AZURE_ARC_LOGIN_SERVER_PROD}/$(app_name):$(version)


.PHONY: authorize_to_aks_staging
authorize_to_aks_staging:
	az aks get-credentials \
		--name ${AKS_CLUSTER_NAME_STAGING} \
		--subscription ${AZURE_SUBSCRIPTION_ID_STAGING} \
		--resource-group ${AZURE_RESOURCE_GROUP_STAGING}

.PHONY: authorize_to_aks_prod
authorize_to_aks_prod:
	az aks get-credentials \
		--name ${AKS_CLUSTER_NAME_PROD} \
		--subscription ${AZURE_SUBSCRIPTION_ID_PROD} \
		--resource-group ${AZURE_RESOURCE_GROUP_PROD}

.PHONY: deploy_to_aks_staging
deploy_to_aks_staging: authorize_to_aks_staging
	kubectl apply -f $(deployment_file_staging)

.PHONY: deploy_to_aks_prod
deploy_to_aks_prod: authorize_to_aks_prod
	kubectl apply -f $(deployment_file_prod)
