FROM pblittle/docker-logstash

MAINTAINER Pavel Vanecek <pavel.vanecek@merck.com>

# Configuration that accepts UDP and TCP syslogs
COPY conf.d /opt/logstash/conf.d

# key + certificate provided to prevent the container from touching public internet
COPY ssl /opt/ssl

# elasticsearch data volume
# see https://github.com/pblittle/docker-logstash/issues/74
VOLUME /data
