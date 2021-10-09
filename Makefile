setup:
	kind create cluster --name fluentd-demo

teardown:
	kind delete clusters fluentd-demo

apply:
	kubectl config use-context kind-fluentd-demo
	kubectl apply -f k8s/deployments.yaml
	kubectl apply -f k8s/services.yaml

MYSQL_POD=$(shell kubectl get pods | grep mysql | awk '{print $$1}')
pfwd-db:
	kubectl port-forward $(MYSQL_POD) 3306

conn-db:
	mysql -u root -h 0.0.0.0 -p123