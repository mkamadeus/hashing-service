# Stage 1
FROM golang:alpine AS builder

ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

WORKDIR /build
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY . .
RUN go build -o main main.go 

WORKDIR /dist
RUN cp /build/main .

# Stage 2
FROM scratch

COPY --from=builder /dist/main /
EXPOSE 3000

CMD ["/main"]