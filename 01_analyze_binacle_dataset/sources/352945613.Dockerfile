FROM ubuntu:17.04

COPY . /bd_build

RUN /bd_build/prepare.sh && \
	/bd_build/system_services.sh && \
	/bd_build/utilities.sh && \
	/bd_build/cleanup.sh

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

CMD ["/sbin/my_init"]
