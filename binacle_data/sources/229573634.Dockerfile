FROM gliderlabs/alpine:3.4
ENV TERM=xterm
RUN apk -U add alpine-sdk coreutils \
  && adduser -G abuild -g "Alpine Package Builder" -s /bin/sh -D builder \
  && echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
  && rm -rf /var/cache/apk/*
ADD entrypoint.sh /bin/
ADD abuild.conf /etc/abuild.conf
RUN mkdir -p /home/builder/package/main/ && chown -R builder /home/builder/
USER builder
ENTRYPOINT ["/bin/entrypoint.sh"]
WORKDIR /home/builder/package
ENV PACKAGER_PRIVKEY /home/builder/abuild.rsa
ADD Dockerfile /alpine-jazz-hands.Dockerfile
