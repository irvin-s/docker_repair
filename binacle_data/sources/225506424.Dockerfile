FROM golang:1.8
RUN mkdir -p /go/src/server
COPY . /go/src/server/
ENV PORT=8090 
RUN go get github.com/cheikhshift/gos
RUN cd /go/src/server && gos deps && gos --export && go install
ENTRYPOINT server
EXPOSE 8090
# healthcheck requires docker 1.12 and up.
# HEALTHCHECK --interval=20m --timeout=3s \
#  CMD curl -f http://localhost:8090/ || exit 1