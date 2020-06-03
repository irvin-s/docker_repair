FROM jwilder/nginx-proxy
MAINTAINER Akvo Foundation <devops@akvo.org>

# Add per-virtual_host default configuration
ADD default.conf /etc/nginx/vhost.d/default
