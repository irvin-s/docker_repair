# inspired by https://github.com/jetstack/elasticsearch-pet/blob/master/Dockerfile
FROM elasticsearch:2.4.1

MAINTAINER Matt Condon <matt@skillshare.com>

# install the kopf frontend for elasticsearch (/kopf)
RUN bin/plugin install lmenezes/elasticsearch-kopf/v2.1.2
# install the fabric8 kubernetes networking pluging to enable multicast discovery
RUN bin/plugin install io.fabric8/elasticsearch-cloud-kubernetes/2.4.1

ENV BOOTSTRAP_MLOCKALL=false \
    NODE_DATA=true \
    NODE_MASTER=true \
    JAVA_OPTS=-Djava.net.preferIPv4Stack=true \
    HTTP_PORT=9200 \
    TRANSPORT_PORT=9300

# pre-stop-hook.sh and dependencies
RUN apt-get update && apt-get install -y \
    jq \
    curl \
 && rm -rf /var/lib/apt/lists/*
COPY pre-stop-hook.sh /pre-stop-hook.sh

# Copy our config files over
ONBUILD COPY config ./config

# Chown the /data volume so we can write our indices there
RUN mkdir -p /data

VOLUME ["/data"]
EXPOSE 9200 9300

COPY ./run.sh /run.sh
RUN chmod +x /run.sh
CMD ["/run.sh"]
