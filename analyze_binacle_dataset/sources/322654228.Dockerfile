# Builder container
FROM golang AS builder

WORKDIR /go/src/dubbo-mesh
COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build --tags "jsoniter prod" -o /root/mesh/agent/consumer ./cmd/consumer/main.go
RUN CGO_ENABLED=0 GOOS=linux go build --tags "jsoniter prod" -o /root/mesh/agent/provider ./cmd/provider/main.go

# Runner container
FROM registry.cn-hangzhou.aliyuncs.com/aliware2018/services AS service
FROM registry.cn-hangzhou.aliyuncs.com/aliware2018/debian-jdk8

COPY --from=service /root/workspace/services/mesh-provider/target/mesh-provider-1.0-SNAPSHOT.jar /root/dists/mesh-provider.jar
COPY --from=service /root/workspace/services/mesh-consumer/target/mesh-consumer-1.0-SNAPSHOT.jar /root/dists/mesh-consumer.jar
COPY --from=service /usr/local/bin/docker-entrypoint.sh /usr/local/bin

COPY build/start-agent.sh /usr/local/bin

COPY --from=builder /root/mesh/agent/consumer /root/dists/consumer
COPY --from=builder /root/mesh/agent/provider /root/dists/provider

RUN set -ex && chmod a+x /usr/local/bin/start-agent.sh  && mkdir -p /root/logs

ENTRYPOINT ["docker-entrypoint.sh"]
