FROM memcached
EXPOSE 11211

USER root
RUN mkdir -p /var/log/memcached && \
  chmod 0777 /var/log/memcached
USER memcache
ADD start.sh /start.sh

VOLUME /var/log/memcached

CMD /start.sh
