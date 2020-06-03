FROM alpine:3.5

RUN apk --update add openssh \
  && rm -rf /var/cache/apk/*

COPY docker-entrypoint.sh /

EXPOSE 22

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D", "-e"]
