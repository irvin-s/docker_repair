FROM python:2.7-slim-stretch
MAINTAINER Toni Moreno <toni.moreno@gmail.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
		curl \
	&& rm -rf /var/lib/apt/lists/*

ADD ./resistor-last.tar.gz /

VOLUME ["/opt/resistor/conf", "/opt/resistor/log"]

EXPOSE 6090

WORKDIR /opt/resistor
COPY ./resistor.toml ./conf/
COPY ./resinjector.toml ./conf/
COPY ./start.sh /
COPY ./start_resinjector.sh /
COPY ./templates /

ENTRYPOINT ["/start.sh"]
