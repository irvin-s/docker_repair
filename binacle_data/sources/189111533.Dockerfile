# Pull base image.
FROM rounds/10m-build

# Install.
RUN \
  add-apt-repository ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/*

# Disable Default website
RUN rm /etc/nginx/sites-enabled/default

# Disable self-daemonize
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

EXPOSE 80 443

# Define default command.
CMD mkdir -p /var/log/nginx; nginx
