FROM ubuntu:14.04

RUN apt-get update && apt-get install -y \
  wget \
  supervisor && \
  mkdir -p /var/log/supervisor

RUN wget --no-check-certificate https://github.com/kelseyhightower/confd/releases/download/v0.7.1/confd-0.7.1-linux-amd64 && \
  chmod +x confd-0.7.1-linux-amd64 && \
  mv confd-0.7.1-linux-amd64 /usr/local/bin/confd && \
  mkdir -p /etc/confd/{conf.d,templates}

ADD kibana-4.0.1-linux-x64.tar.gz /
RUN mv /kibana-4.0.1-linux-x64 /kibana

ADD supervisord.conf /etc/supervisor/supervisord.conf
ADD kill_supervisor.py /usr/bin/kill_supervisor.py
ADD kibana_supervisord.conf /etc/supervisor/conf.d/kibana_supervisord.conf

ADD kibana.yml.tmpl /etc/confd/templates/
ADD kibana.toml /etc/confd/conf.d/
ADD confd.sh /confd.sh
CMD /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
