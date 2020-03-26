# Dockerfile for Autoscale.

FROM node:0.10-slim
COPY src /src
WORKDIR /src

RUN npm install azure-common azure-arm-resource adal-node

ENTRYPOINT ["node","autoscale"]
