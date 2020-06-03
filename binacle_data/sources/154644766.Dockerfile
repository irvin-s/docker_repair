FROM node:10.15-stretch as base-system

# Install grunt-cli globally
RUN npm install -g grunt-cli

COPY .dockerfiles/build-webview.sh /usr/local/bin/

# Create the webview user, group, home directory, and package directory.
# Note, the packaging tools don't like to run as root.
RUN addgroup --system webview && adduser --system --group webview --home /code

# Copy application code into the image
COPY . /code
RUN chown -R webview:webview /code

USER webview
WORKDIR /code

FROM base-system as built

# Specify the type of container to build: 'dev' OR 'prod'
#  - 'dev' will specify that the container should run the source
#  - 'prod' will run as close to production as possible
ARG environment=prod
ENV ENVIRONMENT=${environment}

# Setup the webview application
COPY .dockerfiles/build-webview.sh /usr/local/bin/
RUN build-webview.sh


FROM nginx:latest as serve

# Specify the type of container runtime: 'dev' OR 'prod'
#  - 'dev' will specify that the container should run the source
#  - 'prod' will run as close to production as possible
ARG environment=prod
ENV ENVIRONMENT=${environment}

COPY --from=built /code /code
COPY .dockerfiles/configure-nginx-from-env.sh /usr/local/bin/
COPY .dockerfiles/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
