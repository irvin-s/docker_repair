FROM ubuntu:14.04
# based on baseimage-docker from Phusion <info@phusion.nl>
MAINTAINER Palo Alto Networks TBD Team <techbizdev@paloaltonetworks.com>

ADD . /bd_build

RUN /bd_build/prepare.sh && \
	/bd_build/system_services.sh && \
	/bd_build/utilities.sh && \
	/bd_build/cleanup.sh

EXPOSE 443 13514
VOLUME ["/opt/minemeld/local/"]

CMD ["/sbin/my_init"]
