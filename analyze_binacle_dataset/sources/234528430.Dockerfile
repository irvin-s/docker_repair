# Builds Wysteria by pulling from github
#
FROM golang

# install glide
# > provides 'glide' for installing Go dependencies
RUN curl https://glide.sh/get | sh

# install 'gettext'
# > provides 'envsubst' command so we can write ENV vars to server ini on RUN
RUN apt-get update
RUN apt-get install -y gettext

# clone wysteria
RUN go get github.com/voidshard/wysteria/server

# install dependencies via glide
# > glide will perform a whole lot of go getting for us automagically
WORKDIR $GOPATH/src/github.com/voidshard/wysteria
RUN glide install

# build server
WORKDIR $GOPATH/src/github.com/voidshard/wysteria/server
RUN go build -o server *.go

# set up env vars w/ defaults
# > we'll stick defaults in here (or null, if there is no value). Our bootstrap will use envsubst to write a final
#   config that'll be passed into wysteria on boot
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
ENV WYS_MIDDLEWARE_SSL_CERT null
ENV WYS_MIDDLEWARE_SSL_KEY null
ENV WYS_MIDDLEWARE_SSL_VERIFY false
ENV WYS_MIDDLEWARE_SSL_ENABLE false
ENV WYS_HEALTH_PORT 8150
ENV WYS_HEALTH_ENDPOINT /health
ENV WYS_LOGGER_NAME logs
ENV WYS_LOGGER_DRIVER logfile
ENV WYS_LOGGER_LOCATION /var/log
ENV WYS_LOGGER_TARGET wysteria.log

# expose the nats port
# > if the WYS_NATS_CONFIG connects to another host this wont get used, otherwise the embedded Nats will listen here.
EXPOSE 4222

# expose the grpc default port
EXPOSE 31000

# expose health port
EXPOSE 8150

# add the template ini, and the env substitution bootstrap
ADD wysteria-server.ini.template .
ADD start.sh .

# boot server
ENTRYPOINT ["./start.sh"]
