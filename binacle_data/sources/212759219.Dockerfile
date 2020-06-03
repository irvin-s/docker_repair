FROM nginx:latest

ENV CONSUL_URL consul:8500

RUN apt-get update
RUN apt-get install unzip

ADD start.sh /bin/start.sh
RUN chmod 755 /bin/start.sh

RUN rm -v /etc/nginx/conf.d/*.conf

ADD https://releases.hashicorp.com/consul-template/0.14.0/consul-template_0.14.0_linux_amd64.zip /usr/bin/
RUN unzip /usr/bin/consul-template_0.14.0_linux_amd64.zip -d /usr/local/bin

VOLUME /templates

#EXPOSE 80

#ENTRYPOINT ["/bin/start.sh"]
