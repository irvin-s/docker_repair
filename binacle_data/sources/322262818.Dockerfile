# 暂未将 Golang 集成到 docker 中
FROM alpine:latest
RUN mkdir /app
WORKDIR /app
ADD user-cli /app/user-cli
ENTRYPOINT ["./user-cli"]
CMD ["./user-cli"]