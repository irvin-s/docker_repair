FROM ubuntu:14.04

RUN apt-get update && apt-get install -y \
    golang \
    git \
    make \
    wget \
    supervisor && \
  mkdir -p /var/log/supervisor && \
  git clone https://github.com/driskell/log-courier && \
  cd log-courier && \
  make && \
  cp /log-courier/bin/log-courier /bin/ 

RUN wget --no-check-certificate https://github.com/kelseyhightower/confd/releases/download/v0.7.1/confd-0.7.1-linux-amd64 && \
  chmod +x confd-0.7.1-linux-amd64 && \
  mv confd-0.7.1-linux-amd64 /usr/local/bin/confd && \
  mkdir -p /etc/confd/conf.d && mkdir -p /etc/confd/templates

ADD log-courier.toml /etc/confd/conf.d/log-courier.toml
ADD log-courier.conf /etc/log-courier.conf
ADD confd.sh /confd.sh
RUN chmod +x /confd.sh

ADD supervisor/log_courier_supervisor.conf /etc/supervisor/conf.d/log_courier_supervisord.conf
ADD supervisor/supervisord.conf /etc/supervisor/supervisord.conf
ADD supervisor/kill_supervisor.py /usr/bin/kill_supervisor.py

ADD cron_delete_old_collectd_files /cron/cron_delete_old_collectd_files
RUN cat /cron/cron_delete_old_collectd_files | crontab

CMD mkdir -p /var/log/supervisor && /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
