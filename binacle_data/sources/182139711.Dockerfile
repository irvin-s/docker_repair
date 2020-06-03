FROM quay.io/pires/docker-jre:8u112_1
MAINTAINER pjpires@gmail.com

ENV LOGSTASH_PKG_NAME logstash-5.1.2

# Install Logstash
RUN apk add --update curl bash ca-certificates
RUN \
  ( curl -Lskj https://artifacts.elastic.co/downloads/logstash/$LOGSTASH_PKG_NAME.tar.gz | \
  gunzip -c - | tar xf - ) && \
  mv $LOGSTASH_PKG_NAME /logstash && \
  rm -rf $(find /logstash | egrep "(\.(exe|bat)$|sigar/.*(dll|winnt|x86-linux|solaris|ia64|freebsd|macosx))") && \
  apk del curl wget

# Logstash config
VOLUME ["/logstash/config"]

# Optional certificates folder
VOLUME ["/logstash/certs"]

CMD ["/logstash/bin/logstash", "--quiet",  "-f", "/logstash/config/logstash.conf"]
