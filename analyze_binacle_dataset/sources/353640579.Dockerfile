# dkubb/alpine-rails-nginx

FROM dkubb/alpine-ruby
MAINTAINER Dan Kubb <dkubb@fastmail.com>

ENV BUNDLE_GEMFILE=/opt/rails/Gemfile

COPY etc /etc

# Upgrade installed system dependencies
COPY apk-packages /tmp/
RUN sed 's/#.*$//;/^$/d' /tmp/apk-packages \
  | tr -d ' ' \
  | xargs apk add --update-cache \
  && rm /tmp/apk-packages

# Create system users
RUN adduser -DSH nginx \
  && adduser -DS rails

# Create system directories and service symlinks
RUN setup-directories.sh  root  r  /etc/service/nginx /etc/service/rails \
  && setup-directories.sh nginx rw /var/run/nginx /var/cache/nginx /var/log/nginx \
  && setup-directories.sh rails r  /opt/rails \
  && setup-directories.sh rails rw /var/run/rails /opt/rails/log /opt/rails/tmp \
  && ln -s /etc/sv/nginx /etc/service/nginx/run \
  && ln -s /etc/sv/rails /etc/service/rails/run

# Install nginx
COPY install-nginx.sh nginx.patch /usr/local/src/
RUN /usr/local/src/install-nginx.sh \
  && setup-directories.sh nginx r /etc/nginx \
  && rm -rf /usr/local/src

# Setup bundler for application
RUN cp --recursive ~/.bundle /opt/rails \
  && setup-directories.sh rails r /opt/rails/.bundle
