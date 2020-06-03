FROM ubuntu:14.04

MAINTAINER Anthony Lapenna <lapenna.anthony@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get update && apt-get install -y curl

RUN cd /tmp \
	&& curl -OL https://mms.mongodb.com/download/agent/automation/mongodb-mms-automation-agent-manager_latest_amd64.deb \
	&& dpkg -i mongodb-mms-automation-agent-manager_latest_amd64.deb

RUN mkdir /data && chown mongodb:mongodb /data
