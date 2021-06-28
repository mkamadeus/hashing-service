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
	echo "GET http://localhost:3000" | vegeta attack -duration=10s -rate=3 -timeout=0 | tee result.bin | vegeta report > "./$(shell date +%s).log

# echo "GET http://10.96.153.58:3000" | ./vegeta attack -duration=60s -rate=2 | tee result.bin | ./vegeta report > "./$(date +%s).log"
