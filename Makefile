commands : run build setup-cluster destroy-cluster test
.PHONY : commands

run:
	go build -o main.out main.go 
	./main.out

build:
	go build -o main.out main.go 

setup-cluster:
	kind create cluster
	kubectl apply -f k8s

destroy-cluster:
	kind delete cluster
	
test:
	echo "GET http://localhost:3000" | vegeta attack -duration=10s | tee test.log | vegeta report
