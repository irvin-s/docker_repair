FROM nginx:1.9.12
MAINTAINER Po Chen <chenpaul914@gmail.com>

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update -qq && \
    apt-get -y install curl runit unzip && \
    rm -rf /var/lib/apt/lists/*

ENV CT_URL https://releases.hashicorp.com/consul-template/0.12.2/consul-template_0.12.2_linux_amd64.zip
ENV CT_FN consul-template.zip
RUN curl -L $CT_URL > $CT_FN && unzip $CT_FN -d /usr/local/bin && rm $CT_FN

ADD nginx.service /etc/service/nginx/run
ADD consul-template.service /etc/service/consul-template/run

RUN rm -v /etc/nginx/conf.d/*
ADD nginx.conf /etc/consul-templates/nginx.conf

CMD ["/usr/bin/runsvdir", "/etc/service"]
