FROM phusion/baseimage:0.9.16
MAINTAINER Thor Henning Hetland <totto@totto.org>

ENV DEBIAN_FRONTEND noninteractive

ENV JAVA_HOME /opt/graylog/embedded/jre

RUN apt-get update && \
    apt-get install -y curl ntp ntpdate tzdata && \
    curl -O -L https://packages.graylog2.org/releases/graylog2-omnibus/ubuntu/graylog_latest.deb && \
    dpkg -i graylog_latest.deb && \
    rm graylog_latest.deb && \
    sed -i "0,/^\s*$/s//\/opt\/graylog\/embedded\/share\/docker\/run_graylogctl\n/" /etc/rc.local && \
    sed -i "0,/^\s*$/s//tail\ \-F\ \/var\/log\/graylog\/server\/current\ \&\n/" /etc/rc.local && \
    apt-get clean && \
    rm -rf /tmp/* /var/tmp/*

VOLUME /var/opt/graylog/data
VOLUME /var/log/graylog
VOLUME /opt/graylog/plugin
VOLUME /opt/graylog/conf/nginx/ca

# add plugins
# https://www.graylog.org/sign-in?glredirect=%2Fresource%2Fplugin%2F5453d4e0e4b0d324cb87ad5e%2F
ADD assets/plugin/AWSInput-0.4.0.jar /opt/graylog/plugin/AWSInput-0.4.0.jar  


# web interface
EXPOSE 9000
EXPOSE 443
# gelf tcp
EXPOSE 12201
# gelf udp
EXPOSE 12201/udp
# rest api
EXPOSE 12900
# etcd
EXPOSE 4001
# syslog
EXPOSE 514
EXPOSE 514/udp

CMD ["/opt/graylog/embedded/share/docker/my_init"]

