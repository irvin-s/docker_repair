ARG ALPINE_VERSION=3.7  
FROM alpine:${ALPINE_VERSION} AS builder  
ARG ALPINE_VERSION  
  
RUN apk --no-cache add alpine-sdk coreutils  
  
RUN adduser -G abuild -D builder && \  
echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers  
  
WORKDIR /home/builder/pkg  
RUN chown builder:abuild .  
  
COPY \--chown=builder:abuild pkg/ ./  
  
USER builder  
RUN PACKAGER='Daniel Miranda <daniel@cobli.co>' abuild-keygen -a  
RUN abuild-apk update && abuild -r  
  
###  
FROM alpine:${ALPINE_VERSION}  
  
RUN apk add coreutils openssl ca-certificates --no-cache  
  
COPY \--from=builder /home/builder/.abuild/*.rsa.pub /etc/apk/keys/  
COPY \--from=builder /home/builder/packages/builder/*/squid-4.*.apk /tmp/  
RUN apk add /tmp/squid-4.*.apk --no-cache  
  
COPY entrypoint.sh /usr/local/bin/squid-entrypoint  
RUN chmod 755 /usr/local/bin/squid-entrypoint  
  
COPY squid-tail-logs /usr/local/bin/squid-tail-logs  
RUN chmod 755 /usr/local/bin/squid-tail-logs  
  
COPY gen-ca.sh /usr/local/bin/squid-gen-ca  
RUN chmod 755 /usr/local/bin/squid-gen-ca  
  
RUN rm /etc/squid/squid.conf  
COPY squid.conf.template /etc/squid/  
  
VOLUME /etc/squid/ssl  
VOLUME /var/spool/squid  
  
EXPOSE 3128  
ENTRYPOINT ["/usr/local/bin/squid-entrypoint"]  
CMD ["squid-tail-logs", "squid", "-N", "-C"]  

