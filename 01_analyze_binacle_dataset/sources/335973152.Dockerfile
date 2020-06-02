FROM alpine:3.6
MAINTAINER iota-tangle.io

# create frontend dirs /app/frontend/...
RUN mkdir -p /app/frontend/css \
&& mkdir -p /app/frontend/html \
&& mkdir -p /app/frontend/js

# create backend dirs /app/backend/cmd...
RUN mkdir -p     /app/backend/cmd/configs \
&& mkdir -p     /app/backend/cmd/logs

# copy backend binary
COPY backend/cmd/slave /app/backend/cmd

# copy spa assets
COPY frontend/css/*                 /app/frontend/css/
COPY frontend/html/*                /app/frontend/html/
COPY frontend/js/bundle.min.js      /app/frontend/js

# volumes
VOLUME /app/backend/cmd/configs
VOLUME /app/backend/cmd/logs

# envs
ENV PRODUCTION_MODE yes

# workdir and ports
WORKDIR /app/backend/cmd
EXPOSE 9000

# entrypoint
ENTRYPOINT ["/app/backend/cmd/slave"]