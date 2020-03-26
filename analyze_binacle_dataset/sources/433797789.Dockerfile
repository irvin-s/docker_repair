FROM jwilder/nginx-proxy
MAINTAINER Akvo Foundation <devops@akvo.org>

# Add default single configuration for cartodb vhosts
ADD default.conf /etc/nginx/vhost.d/default
