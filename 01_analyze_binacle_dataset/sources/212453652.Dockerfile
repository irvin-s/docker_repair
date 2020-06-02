FROM redis:3.2.0
MAINTAINER Charles Lescot <lescot.charles[@]gmail.com:>
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y curl sed 

COPY giddyup /usr/local/bin/giddyup
RUN chmod 777 /usr/local/bin/giddyup

COPY conf/redis.conf /usr/local/etc/redis/redis.conf
COPY  start-redis.sh /start-redis.sh
RUN chmod 777 /start-redis.sh
CMD [ "/start-redis.sh"]
