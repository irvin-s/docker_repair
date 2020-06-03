FROM ubuntu:bionic

COPY install.sh /tmp/install.sh
COPY run.sh /run.sh
COPY nsca.conf /etc/supervisor/conf.d/nsca.conf
COPY apache2_supervisor.conf /etc/supervisor/conf.d/apache2.conf

RUN chmod +x /tmp/install.sh && chmod +x /run.sh 
RUN /tmp/install.sh

VOLUME ["/icinga2conf","/mysql","/icingaweb2"]

EXPOSE 80 5667 5665

CMD ["/run.sh"]
