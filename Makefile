commands : run build make-cluster apply-deployment port-forward destroy-cluster test
.PHONY : commands

run:
	go build -o main.out main.go 
	./main.out

build:
	go build -o main.out main.go 

setup: make-cluster apply-deployment

make-cluster:
	kind create cluster

apply-deployment:
	kubectl apply -f k8s

port-forward:
	kubectl port-forward deployments/hashing-service 3000:3000

destroy-cluster:
	kind delete cluster
	
test:
	echo "GET http://localhost:3000" | vegeta attack -duration=5s -rate=5 | tee result.bin | vegeta report > "./logs/$(shell date +%s).log"
