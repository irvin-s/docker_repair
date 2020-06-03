FROM base

RUN apt-get update
RUN apt-get install -y git curl build-essential make gcc wget

ENV VERSION 2.6.16
RUN wget http://download.redis.io/releases/redis-$VERSION.tar.gz
RUN tar xzf redis-$VERSION.tar.gz
RUN cd redis-$VERSION && make
RUN ln -sfn redis-$VERSION redis
RUN mkdir /data
RUN mkdir /logs

VOLUME [ "/logs" ]
VOLUME [ "/data" ]

ADD redis.conf redis.conf

EXPOSE 6379

CMD ["redis/src/redis-server", "redis.conf"] 
