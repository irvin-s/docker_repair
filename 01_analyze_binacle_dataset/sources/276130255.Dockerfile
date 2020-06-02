FROM alpine
LABEL maintainer "."
RUN apk update && apk add ca-certificates
ADD mashling.json .
ADD mashling-gateway .
CMD ./mashling-gateway -c mashling.json
