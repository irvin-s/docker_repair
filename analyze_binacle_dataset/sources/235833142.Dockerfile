FROM gcr.io/percy-dev/baseimage-web:2018-06-27-230729

# Configure nginx.
ADD config/nginx-main.conf /etc/nginx/nginx.conf
ADD config/nginx-default-site.conf /etc/nginx/sites-enabled/default

# Configure nginx to run automatically.
ADD config/run-nginx.sh /etc/service/nginx/run
RUN chmod +x /etc/service/*/run

# Setup the app directory and build the ember app.
ADD package.json yarn.lock bower.json /app/src/
WORKDIR /app/src/
RUN yarn install --pure-lockfile
RUN bower install --allow-root
# Setup the full app directory (do this after package install to speed up docker builds).
ADD . /app/src/

ARG testing="false"
ARG version

ENV VERSION=$version

RUN if [ "$testing" = "true" ] ; then \
  yarn run build-test; \
else \
  yarn run build-production; \
fi
