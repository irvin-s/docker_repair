FROM texastribune/base
MAINTAINER danielc@pobox.com

RUN apt-get update && \
      apt-get -yq install postgresql-client git wget curl && \
      pip install postdoc

# install Go
ADD https://storage.googleapis.com/golang/go1.3.3.linux-amd64.tar.gz /app/
RUN tar -C /usr/local -xzf /app/go1.3.3.linux-amd64.tar.gz
ENV PATH /usr/local/go/bin:/usr/local/bin:/usr/bin:/bin:/app/go/bin:/usr/local/sbin:/sbin:/usr/sbin

RUN mkdir -p /app/go
ENV GOPATH /app/go
