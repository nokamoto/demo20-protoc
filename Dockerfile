FROM golang:1.15 as protoc-gen-go

RUN go get -u -d github.com/golang/protobuf/protoc-gen-go

RUN git -C "$(go env GOPATH)"/src/github.com/golang/protobuf checkout v1.4.2

RUN go install github.com/golang/protobuf/protoc-gen-go

FROM debian:10.5-slim as protoc

RUN apt-get update && apt-get install -y curl unzip

RUN curl -LO https://github.com/protocolbuffers/protobuf/releases/download/v3.13.0/protoc-3.13.0-linux-x86_64.zip

RUN unzip protoc-3.13.0-linux-x86_64.zip

FROM debian:10.5-slim

RUN apt-get update && apt-get install -y git

COPY --from=protoc-gen-go /go/bin/protoc-gen-go /usr/local/bin/protoc-gen-go

COPY --from=protoc /include /usr/local/include
COPY --from=protoc /bin/protoc /usr/local/bin/protoc

RUN chmod +x /usr/local/bin/protoc-gen-go
RUN chmod +x /usr/local/bin/protoc
