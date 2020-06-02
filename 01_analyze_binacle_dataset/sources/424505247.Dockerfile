FROM cikl/base:0.0.2
MAINTAINER Mike Ryan <falter@gmail.com>

RUN \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y nginx m4 make && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# Define mountable directories.
VOLUME [ "/var/lib/nginx", "/data" ]

# Define working directory.
WORKDIR /data

RUN rm /etc/nginx/sites-enabled/default

ADD docker/cikl-ui.conf.m4 /etc/nginx/cikl-ui.conf.m4
ADD docker/nginx.conf /etc/nginx/nginx.conf
ADD docker/ui-pre.sh /etc/docker-entrypoint/pre.d/ui-pre.sh
ADD docker/nginx-pre.sh /etc/docker-entrypoint/pre.d/nginx-pre.sh
ADD docker/nginx-command.sh /etc/docker-entrypoint/commands.d/nginx
RUN chmod a+x /etc/docker-entrypoint/commands.d/nginx

ADD public/ /opt/cikl-ui/public

# Expose ports.
EXPOSE 80

CMD [ "nginx" ]
