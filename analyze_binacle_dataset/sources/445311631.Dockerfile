FROM golang AS build

ADD . /go/src/mafia-backend

RUN sh /go/src/mafia-backend/bin/build.sh

FROM scratch

COPY --from=build /go/src/mafia-backend/bin/server /server

EXPOSE 8000

STOPSIGNAL SIGTERM

ENTRYPOINT ["/server", "--port=8000"]