FROM oneops/centos7

# logstash
COPY logstash.repo /etc/yum.repos.d/logstash.repo
RUN yum -y install logstash openssl

RUN mkdir -p /etc/pki/tls/logstash/certs
RUN mkdir -p /etc/pki/tls/logstash/private

WORKDIR /etc/pki/tls/logstash
RUN openssl req -x509 -batch -nodes -days 3650 -newkey rsa:2048 -keyout private/logstash-forwarder.key -out certs/logstash-forwarder.crt -subj '/CN=*.oneops_default/'

COPY logstash.sh /opt/logstash.sh
COPY logstash.conf /etc/logstash/conf.d/logstash.conf

COPY logstash.ini /etc/supervisord.d/logstash.ini
