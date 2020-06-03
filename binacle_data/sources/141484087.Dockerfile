FROM gliderlabs/alpine:3.1
MAINTAINER vlad-x <vlad@oppex.com>
# docker run --name zk-navigator -d -e ZK=172.17.42.1:5000 vbond/zk-navigator

WORKDIR /app
COPY . /app

RUN apk --update add python py-pip openssl ca-certificates
RUN apk --update add --virtual build-dependencies python-dev build-base wget \
  && pip install kazoo

CMD ["python", "fe.py"]
