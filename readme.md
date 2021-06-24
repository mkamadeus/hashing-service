# hashing-service

Sample hashing service created using Golang. This service does 100 bcrypt hashing with cost of 2. This service was created to test HPAs on Kubernetes.

## Requirements

- Docker (http://docker.io/)
- kind (https://kind.sigs.k8s.io/)
- kubectl (https://kubernetes.io/docs/reference/kubectl/)
- Vegeta (https://github.com/tsenart/vegeta)

## Using the Service

### Compiling from source

```bash
go build -o main.out main.go
./main.out

# OR

make run
```

### Running as Docker Container

This service is containerized for convenience. To run it as a Docker container:

```bash
docker pull ghcr.io/mkamadeus/hashing-service:latest
docker run -p 3000:3000 ghcr.io/mkamadeus/hashing-service:latest
```

### Running in a Local Kubernetes Cluster

After installing the required requirements, you can setup a new cluster with the services installed.

```bash
cd ./hashing-service
kind create cluster
kubectl apply -f k8s
```

After applying the Kubernetes configuration, several things should be made:

- Hashing service deployment, defined in `deployment.yaml`
- Port service, defined in `service.yaml`
- The metric server for HPA use, defined in `metric-server.yaml`
- The HPA deployment, defined in `hpa.yaml`

To test the service from the host machine, port-forward your services by typing:

```bash
kubectl port-forward deployments/hashing-service 3000:3000
```

After running the previous command, you can run `make test` to do a stress test using Vegeta.

To delete the cluster:

```bash
kind delete cluster
```
