FROM joshula/redis-sentinel
MAINTAINER Charles Lescot <lescot.charles[@]gmail.com:>

COPY giddyup /usr/local/bin/giddyup
RUN chmod 777 /usr/local/bin/giddyup

ADD sentinel.conf /etc/redis/sentinel.conf

COPY  start-sentinel.sh /start-sentinel.sh
RUN chmod 777 /start-sentinel.sh
ENTRYPOINT [ "/start-sentinel.sh"]
