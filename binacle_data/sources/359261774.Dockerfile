FROM debian:jessie
MAINTAINER Jessica Frazelle <jess@docker.com>


EXPOSE 80

RUN apt-get update && apt-get install -y \
    ca-certificates \
    --no-install-recommends

ENTRYPOINT [ "/usr/local/bin/leeroy" ]

#ADD https://jesss.s3.amazonaws.com/binaries/leeroy /usr/local/bin/leeroy
ADD leeroy /usr/local/bin/leeroy
RUN chmod +x /usr/local/bin/leeroy
COPY config.json /etc/leeroy/config.json
