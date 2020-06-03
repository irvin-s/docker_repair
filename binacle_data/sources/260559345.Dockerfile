FROM kibana:4.6.2

MAINTAINER Matt Condon <matt@skillshare.com>

COPY ./kibana.yml /opt/kibana/config/kibana.yml
