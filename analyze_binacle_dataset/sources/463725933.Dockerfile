FROM ubuntu

RUN mkdir -p /usr/local/bin
RUN apt-get update && \
  apt-get -y --no-install-recommends install wget ca-certificates git
RUN \
  wget -O /usr/local/bin/dumb-init \
  https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64 && \
  echo "057ecd4ac1d3c3be31f82fc0848bf77b1326a975b4f8423fe31607205a0fe945 /usr/local/bin/dumb-init" | \
    sha256sum -c - && \
  chmod 755 /usr/local/bin/dumb-init

FROM alpine:latest

RUN apk update && apk --no-cache add bash bc bind-tools python2 py-pip \
  git sudo openssl coreutils curl socat \
  && rm -rf /var/cache/apk/*

RUN pip install docutils && pip install python-daemon
RUN pip install git+git://github.com/paulchakravarti/dnslib.git@986861873ee6131dae60820b8a804f710f87dd8

COPY --from=0 /usr/local/bin/dumb-init /usr/local/bin/dumb-init
COPY start.sh /bin/start.sh
COPY nano-dns.py /bin/nano-dns.py
RUN chown root:root /bin/nano-dns.py /bin/start.sh && \
  chmod 555 /bin/nano-dns.py /bin/start.sh

VOLUME /successes
VOLUME /etc/nginx/certs

RUN adduser -s /bin/bash -S -u 1000 -G users renewer
RUN addgroup -S nano-dns
RUN adduser -s /bin/bash -S -u 1001 -G nano-dns nano-dns

RUN echo \
  "renewer ALL=(root) NOPASSWD: /bin/nano-dns.py nano-dns /nanodns/config.txt" >> \
  /etc/sudoers
RUN echo \
  "renewer ALL=(nano-dns) NOPASSWD: /bin/cat /etc/nginx/certs/ssl/perm-test" >> \
  /etc/sudoers

USER renewer

RUN cd /home/renewer && \
  git clone https://github.com/Neilpang/acme.sh.git && \
  cd ./acme.sh && \
  mkdir /home/renewer/.acme.sh && \
  mv acme.sh /home/renewer/.acme.sh/ && \
  cd /home/renewer && \
  rm -rf ./acme.sh

USER root

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]

CMD ["/bin/start.sh"]
