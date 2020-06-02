#
# Dockerfile for serverspeeder
#

FROM ubuntu:trusty
MAINTAINER xzdbd <xzdbd@sina.com>

RUN set -ex &&\
	apt-get update && \
	apt-get install -y wget &&\
	wget -N --no-check-certificate https://raw.githubusercontent.com/91yun/serverspeeder/master/serverspeeder-all.sh && bash serverspeeder-all.sh

CMD ["/bin/bash"]
