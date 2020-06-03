FROM scratch

MAINTAINER e2tox <e2tox@microbox.io>

ADD rootfs.tar /

WORKDIR /app

EXPOSE 9000

ENTRYPOINT ["./dockerui"]
CMD ["-e", "/docker.sock"]