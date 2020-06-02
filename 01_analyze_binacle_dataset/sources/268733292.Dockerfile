FROM alpine:latest
MAINTAINER liberalman liberalman@github.com

# install nginx runit curl
RUN apk --update --no-cache add nginx curl runit

#ENV CT_URL http://releases.hashicorp.com/consul-template/0.19.0/consul-template_0.19.0_linux_amd64.tgz
#RUN curl -L $CT_URL | tar -C /usr/local/bin/ --strip-components 1 -zxf -
ADD consul-template_0.19.0_linux_amd64.tgz /usr/local/bin/

ADD nginx.service /etc/service/nginx/run
RUN chmod a+x /etc/service/nginx/run
ADD consul-template.service /etc/service/consul-template/run
RUN chmod a+x /etc/service/consul-template/run

RUN rm -v /etc/nginx/conf.d/*
RUN mkdir -p /run/nginx/
ADD nginx.conf.ctmpl /etc/consul-templates/nginx.conf.ctmpl

CMD ["runsvdir", "/etc/service"]
