FROM ubuntu:latest as builder

LABEL maintainer="Rico <rico93@outlook.com>"
LABEL V2Ray = "4.12.0"

ENV v2ray_version=4.12.0

RUN apt-get update
RUN apt-get install curl -y
RUN curl -L -o /tmp/go.sh https://raw.githubusercontent.com/rico93/v2ray-core/master/release/install-release.sh
RUN chmod +x /tmp/go.sh
RUN /tmp/go.sh --version ${v2ray_version}


RUN runDeps="gcc python3-dev python3-pip python3-setuptools git"\
	&& set -ex  \
    && apt-get install -y ${runDeps}  \
    && apt-get autoclean \
    && chmod +x /usr/bin/v2ray/v2ctl  \
    && chmod +x /usr/bin/v2ray/v2ray \
    && cd /etc/ \
	&& git clone -b v2ray_api https://github.com/rico93/shadowsocks-munager.git \
    && cd shadowsocks-munager \
    && cp config/config_example.yml config/config.yml \
    && cp config/config.json /etc/v2ray/config.json \
    && pip3 install -r requirements.txt

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV PATH /usr/bin/v2ray:$PATH
VOLUME /etc/v2ray/ /etc/shadowsocks-munager/ /var/log/v2ray/
WORKDIR /etc/shadowsocks-munager
CMD sed -i "s|\"port\": 2333,|\"port\": ${api_port},|"  /etc/v2ray/config.json && \
    sed -i "s|api_port:.*|api_port: ${api_port}|"  /etc/shadowsocks-munager/config/config.yml && \
    sed -i "s|docker:.*|docker: ${docker}|"  /etc/shadowsocks-munager/config/config.yml && \
    sed -i "s|node_id:.*|node_id: ${node_id}|"  /etc/shadowsocks-munager/config/config.yml && \
    sed -i "s|sspanel_url:.*|sspanel_url: '${sspanel_url}'|"  /etc/shadowsocks-munager/config/config.yml && \
    sed -i "s|key:.*|key: '${key}'|"  /etc/shadowsocks-munager/config/config.yml && \
    sed -i "s|speedtest:.*|speedtest: ${speedtest}|"  /etc/shadowsocks-munager/config/config.yml && \
    (nohup v2ray -config=/etc/v2ray/config.json >/dev/null 2>&1 & )&& \
    python3 run.py --config-file=/etc/shadowsocks-munager/config/config.yml
