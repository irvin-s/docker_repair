FROM ubuntu:yakkety

RUN apt-get update && apt-get install -y haproxy ruby

RUN gem install multibinder

ENV MULTIBINDER_SOCK=/run/multibinder.sock

ENV CONFIG=/etc/haproxy/site.cfg.erb

ENTRYPOINT /usr/local/bin/multibinder-haproxy-wrapper /usr/sbin/haproxy -Ds -f $CONFIG -p /var/run/haproxy-site.pid