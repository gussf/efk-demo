setup:
	kind create cluster --name efk-demo
	helm repo add elastic https://helm.elastic.co
	helm repo update

teardown:
	kind delete clusters efk-demo

apply:
	kubectl config use-context kind-efk-demo
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

image:
	docker build -t gussf/efk-demo .
	docker push gussf/efk-demo