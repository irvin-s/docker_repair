FROM node:9.4-alpine

COPY . ./

RUN npm install

ENTRYPOINT ["./bin/hubot"]
CMD ["-a", "shell"]
