FROM alpine
LABEL maintainer "."
RUN apk update && apk add ca-certificates
ADD mashling-gateway .
ADD mashling.json .
EXPOSE 9096
CMD ./mashling-gateway -c mashling.json
