FROM microbox/scratch

MAINTAINER e2tox <e2tox@microbox.io>

RUN mkdir /app

ADD dist     /app/
ADD dockerui /app/

WORKDIR /app

EXPOSE 9000

ENTRYPOINT ["/app/dockerui"]
CMD ["-e", "/docker.sock"]

