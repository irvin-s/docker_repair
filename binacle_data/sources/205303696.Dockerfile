FROM alpine:3.3
COPY node_modules /bitbloq-frontend/node_modules
COPY bower_components /bitbloq-frontend/bower_components
COPY bower-template.json /bitbloq-frontend/bower-template.json
COPY package-template.json /bitbloq-frontend/package-template.json
CMD ["/bin/sh", "-c", "sleep 2000000000000000000"]
