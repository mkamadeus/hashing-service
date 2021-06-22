# hashing-service

Sample hashing service created using Golang. This service does 100 bcrypt hashing with cost of 2. This service was created to test HPAs on Kubernetes.

## Using the Service

This service is containerized for convenience.

```bash
docker pull ghcr.io/mkamadeus/hashing-service:latest
docker run -p 3000:3000 ghcr.io/mkamadeus/hashing-service:latest
```
