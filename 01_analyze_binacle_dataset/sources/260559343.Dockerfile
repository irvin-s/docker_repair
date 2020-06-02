FROM gcr.io/google_containers/fluentd-elasticsearch:1.19

MAINTAINER Matt Condon <matt@skillshare.com>

COPY td-agent.conf /etc/td-agent/td-agent.conf
