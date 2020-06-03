FROM rounds/10m-base
MAINTAINER Ofir Petrushka ROUNDS <ofir@rounds.com>

# Generic (should be in base images if this issue https://github.com/docker/docker/issues/3639 is ever resolved)
VOLUME ["/var/log"] 

RUN apt-get update && \
    apt-get install -y git && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["git"]
