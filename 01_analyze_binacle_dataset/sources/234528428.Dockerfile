# Builds server using the local wysteria src code.
# This is used for testing wysteria internally and isn't intended to be generally helpful to others.
#
FROM golang

# install glide
# > provides 'glide' for installing Go dependencies
RUN curl https://glide.sh/get | sh

# install 'gettext'
# > provides 'envsubst' command so we can write ENV vars to server ini on RUN
RUN apt-get update
RUN apt-get install -y gettext

# make dir & install depends
RUN mkdir -p $GOPATH/src/github.com/voidshard/wysteria
WORKDIR $GOPATH/src/github.com/voidshard/wysteria
ADD glide.lock .
ADD glide.yaml .
RUN glide install

# whack in local wysteria files
ADD server server
ADD client client
ADD common common

# build server
WORKDIR $GOPATH/src/github.com/voidshard/wysteria/server
RUN go build -o server *.go

# expose the nats port
EXPOSE 4222

# expose the grpc default port
EXPOSE 31000

# expose health port
EXPOSE 8150

# set up env vars w/ defaults
# > we'll stick defaults in here (or null, if there is none). Our bootstrap will use envsubst to write a final config
#   that'll be passed into wysteria on boot
ENV WYS_DATABASE_DRIVER bolt
ENV WYS_DATABASE_NAME wysteria_d
ENV WYS_DATABASE_PORT null
ENV WYS_DATABASE_HOST null
ENV WYS_DATABASE_USER null
ENV WYS_DATABASE_PASS null
ENV WYS_DATABASE_PEM null2
ENV WYS_SEARCHBASE_DRIVER bleve
ENV WYS_SEARCHBASE_NAME wysteria_s
ENV WYS_SEARCHBASE_PORT null
ENV WYS_SEARCHBASE_HOST null
ENV WYS_SEARCHBASE_USER null
ENV WYS_SEARCHBASE_PASS null
ENV WYS_SEARCHBASE_PEM null
ENV WYS_SEARCHBASE_REINDEX false
ENV WYS_MIDDLEWARE_DRIVER grpc
ENV WYS_MIDDLEWARE_CONFIG :31000
ENV WYS_MIDDLEWARE_SSL_CERT /usr/ssl/test.crt
ENV WYS_MIDDLEWARE_SSL_KEY /usr/ssl/test.key
ENV WYS_MIDDLEWARE_SSL_VERIFY false
ENV WYS_MIDDLEWARE_SSL_ENABLE false
ENV WYS_HEALTH_PORT 8150
ENV WYS_HEALTH_ENDPOINT /health
ENV WYS_LOGGER_NAME logs
ENV WYS_LOGGER_DRIVER logfile
ENV WYS_LOGGER_LOCATION /var/log
ENV WYS_LOGGER_TARGET wysteria.log

# add test certs
RUN mkdir /usr/ssl/
WORKDIR /usr/ssl/
ADD test.crt .
ADD test.csr .
ADD test.key .

# add the template ini, and the env substitution bootstrap
WORKDIR $GOPATH/src/github.com/voidshard/wysteria/server
ADD wysteria-server.ini.template .
ADD start.sh .

# boot server
ENTRYPOINT ["./start.sh", "-v"]
