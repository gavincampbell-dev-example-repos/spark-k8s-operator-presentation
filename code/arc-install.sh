# https://docs.microsoft.com/en-us/azure/azure-arc/kubernetes/quickstart-connect-cluster?tabs=azure-cli
az extension add --name connectedk8s
az extension add -n k8s-configuration
az extension add -n k8s-extension


az provider register --namespace Microsoft.Kubernetes
az provider register --namespace Microsoft.KubernetesConfiguration
az provider register --namespace Microsoft.ExtendedLocation

az provider register --namespace Microsoft.ContainerService

#Wait!
az group create --name ArcDemo --location northeurope

az connectedk8s connect --name SparkK8sDemo --resource-group ArcDemo

az k8s-extension create --name azuremonitor-containers --cluster-name SparkK8sDemo --resource-group ArcDemo --cluster-type connectedClusters --extension-type Microsoft.AzureMonitor.Containers

