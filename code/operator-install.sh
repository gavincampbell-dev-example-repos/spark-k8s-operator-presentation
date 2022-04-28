helm repo add spark-operator https://googlecloudplatform.github.io/spark-on-k8s-operator

helm install spark-operator-release spark-operator/spark-operator \
--namespace spark-operator --create-namespace \
--set image.tag=v1beta2-1.3.2-3.1.1 --set image.repository=ghcr.io/googlecloudplatform/spark-operator