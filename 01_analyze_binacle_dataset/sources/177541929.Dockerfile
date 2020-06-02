FROM hopsoft/graphite-statsd
RUN rm -rf /etc/service/statsd/
ADD storage-schemas.conf /opt/graphite/conf/storage-schemas.conf
ADD carbon.conf /opt/graphite/conf/carbon.conf
