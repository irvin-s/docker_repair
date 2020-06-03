FROM alpine:3.3
COPY node_modules /bitbloq-backend/node_modules
COPY package-template.json /bitbloq-backend/package-template.json
CMD ["/bin/sh", "-c", "sleep 2000000000000000000"]
