setup:
	kind create cluster --name fluentd-demo
	helm repo add elastic https://helm.elastic.co
	helm repo update

teardown:
	kind delete clusters fluentd-demo

apply:
	kubectl config use-context kind-fluentd-demo
	helm install elasticsearch elastic/elasticsearch --values k8s/elastic-values.yaml
	helm install kibana elastic/kibana
	kubectl apply -f k8s/deployments.yaml
	kubectl apply -f k8s/services.yaml

MYSQL_POD=$(shell kubectl get pods | grep mysql | awk '{print $$1}')
pfwd-db:
	kubectl port-forward $(MYSQL_POD) 3306

conn-db:
	mysql -u root -h 0.0.0.0 -p123

kibana:
	kubectl port-forward service/kibana-kibana 5601