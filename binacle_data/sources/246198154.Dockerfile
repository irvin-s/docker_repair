FROM golang:alpine
MAINTAINER Transceptor Technology
RUN apk update
RUN apk upgrade
RUN apk add git python3 nodejs-npm libc-dev
RUN npm install -g less@2.7.2 less-plugin-clean-css
RUN git clone https://github.com/SiriDB/siridb-admin.git /tmp/siridb-admin
RUN cd /tmp/siridb-admin && ./gobuild.py -i -l -w -b -p -o siridb-admin

FROM alpine:latest
COPY --from=0 /tmp/siridb-admin/siridb-admin /usr/local/bin/siridb-admin
# Client connections
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/siridb-admin"]
