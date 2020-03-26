# 暂未将 Golang 集成到 docker 中
FROM alpine:latest
RUN mkdir /app
WORKDIR /app
ADD vessel-service /app/vessel-service
CMD ["./vessel-service"]