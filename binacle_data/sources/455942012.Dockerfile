FROM golang:1.8

ENV SHEETS_INFLUX_CLIENT_SECRET_JSON ${SHEETS_INFLUX_CLIENT_SECRET_JSON}
ENV SHEETS_INFLUX_TOKEN_JSON ${SHEETS_INFLUX_TOKEN_JSON}

WORKDIR /go/src/app
COPY sheets-importer .

RUN go-wrapper download
RUN go-wrapper install

ADD ./run.sh /run.sh

RUN chmod 777 .

CMD ["/run.sh"]
