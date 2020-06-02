FROM google/golang

RUN mkdir -p /app/buckets /etc/file-bucket/

WORKDIR /app/

ADD . /app/
ADD config.json /etc/file-bucket/

RUN go build file-bucket.go

VOLUME /app/buckets

EXPOSE 1234

CMD /app/file-bucket
