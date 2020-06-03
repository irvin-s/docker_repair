# Docker Image for docker-resource-monitor

FROM node:latest

CMD ["/app/monitor.js"]

ADD . /app
WORKDIR /app
RUN npm install
