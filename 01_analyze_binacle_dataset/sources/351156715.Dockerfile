FROM debian:jessie

MAINTAINER Joeri Verdeyen <joeriv@yappa.be>

ENV HTTP_PORT 1080
ENV SMTP_PORT 1025

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -q -y \
    libsqlite3-dev \
    curl \
    ruby \    
    ruby-dev \
    build-essential && \
    gem install --no-ri --no-rdoc mailcatcher && \
    apt-get remove -y build-essential && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists

RUN echo Europe/Brussels > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

EXPOSE 1080 1025

COPY run.sh /run.sh
RUN chmod +x /run.sh
CMD ["/run.sh"]
