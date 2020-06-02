FROM untoldwind/dose:base-v4

RUN apt-get install -y elasticsearch=1.1.1
RUN apt-get install -y logstash=1.4.2-1-2c0f5a1

ADD https://download.elasticsearch.org/kibana/kibana/kibana-3.1.2.tar.gz /root/
ADD sources/pki /etc/pki/server/
ADD sources/logstash /etc/logstash/conf.d/
ADD sources/supervisor /etc/supervisor/conf.d
ADD sources/consul /etc/consul.d

RUN mkdir -p /var/run/elasticsearch
RUN mkdir -p /usr/share/kibana3

WORKDIR /usr/share/kibana3
RUN /bin/tar xzf /root/kibana-3.1.2.tar.gz --strip-components=1
ADD sources/kibana-nginx.conf /etc/nginx/sites-enabled/kibana
ADD sources/config.js /usr/share/kibana3/config.js
ADD sources/logstash_forwarder/logstash-forwarder /etc/logstash-forwarder

EXPOSE 22 80 5000

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
