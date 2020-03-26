# base docker-xrtc
FROM peterxu/docker-xrtc:latest

COPY testing/routes.yml /tmp/etc/routes.yml
COPY testing/certs/key.pem /tmp/etc/cert.key
COPY testing/certs/cert.pem /tmp/etc/cert.pem
ADD xrtc.gen /usr/bin/xrtc

EXPOSE 6000/udp 6080/tcp 6443/tcp

ADD testing/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/xrtc"]
