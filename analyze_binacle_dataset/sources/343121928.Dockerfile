FROM debian:stretch-slim

LABEL maintainer="Angristan https://github.com/Angristan/dockerfiles"
LABEL source="https://github.com/Angristan/dockerfiles/tree/master/tor"

ENV GID=4242 UID=4242

RUN apt-get update \
    && apt-get dist-upgrade \
    && apt-get install -y gnupg2 \
    && echo "deb http://deb.torproject.org/torproject.org stretch main" > /etc/apt/sources.list.d/tor.list \
    && gpg --keyserver keys.gnupg.net --recv A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 \
    && gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add - \
    && apt-get update \
    && apt-get install -y \
    tor \
    deb.torproject.org-keyring \
    && apt-get clean

COPY run.sh /usr/local/bin/run.sh

RUN chmod +x /usr/local/bin/run.sh

EXPOSE 9001 9030

VOLUME ["/var/lib/tor"]

CMD ["run.sh"]