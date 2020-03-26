FROM centos:7

COPY cli/cachet_monitor /usr/local/bin/cachet_monitor
COPY scripts/startCachet.sh /usr/local/bin/startCachet.sh

RUN chmod +x /usr/local/bin/cachet_monitor
RUN chmod +x /usr/local/bin/startCachet.sh

RUN mkdir -p /www/log
RUN mkdir -p /www/conf
RUN mkdir -p /www/scripts

VOLUME /www/log
VOLUME /www/conf
VOLUME /www/scripts

ENTRYPOINT [ "/usr/local/bin/startCachet.sh" ]
