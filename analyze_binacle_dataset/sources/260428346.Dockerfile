FROM tomb/ubuntu:base1404

# Install basic packages
RUN apt-get install -y redis-server

ADD redis.conf /etc/redis/redis.conf
ADD init /init
RUN chmod 755 /init

# redis data dir
RUN mkdir -p /home/redis
VOLUME ["/home/redis"]
EXPOSE 6379
EXPOSE 22
CMD /init && /usr/sbin/sshd -D
