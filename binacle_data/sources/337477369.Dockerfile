FROM golang:1.10-stretch

# disable interactive functions
ENV DEBIAN_FRONTEND noninteractive

# install glide
RUN go get -u github.com/Masterminds/glide

# install mongodb and mongod daemon because of globalsign/mgo/dbtest
RUN APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=noninteractive apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4 \
    && echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/4.0 main" | tee /etc/apt/sources.list.d/mongodb-org-4.0.list \
    && apt-get update \
    && apt-get install -y mongodb-org

# change the current working directory
WORKDIR /go/src/github.com/gofreta/gofreta-api

# expose api host port
EXPOSE 8090
