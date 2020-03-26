# Graphite stack

FROM graphiteapp/graphite-statsd:1.1.5-7

# Graphite
COPY carbon.conf /opt/graphite/conf/carbon.conf
# https://github.com/graphite-project/docker-graphite-statsd/pull/66/commits/9092b00ed236c4b9d4864fa2f0731486987078eb#diff-3254677a7917c6c01f55212f86c57fbfR121
COPY storage-schemas.conf /opt/graphite/conf/storage-schemas.conf
COPY storage-aggregation.conf /opt/graphite/conf/storage-aggregation.conf
# StatsD
COPY statsd_config.js /etc/statsd/config.js
# Graphite API
COPY graphite-api.yaml /etc/graphite-api.yaml

# nginx
# Ports
##Graphite API 8080; Carbon line receiver 2003; Cabon pickle receiver 2004; 
##Carbon cache query 7002; StatsD UDP 8125; StatsD Admin 8126 
EXPOSE 80 \
# graphite-api
8080 \
# Carbon line receiver
2003 \
# Carbon pickle receiver
2004 \
# Carbon cache query
7002 \
# StatsD UDP
8125 \
# StatsD Admin
8126

# Launch stack
# https://github.com/graphite-project/docker-graphite-statsd/pull/66/commits/9092b00ed236c4b9d4864fa2f0731486987078eb
ENTRYPOINT ["/entrypoint"]
