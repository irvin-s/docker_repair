FROM alpine

RUN apk --update add ca-certificates && rm -rf /var/cache/apk/*

# Prepare
WORKDIR /
RUN mkdir -p /bin
RUN mkdir -p /etc/ladder

# put ladder
COPY ./bin/ladder /bin/ladder
RUN chmod 755 /bin/ladder

EXPOSE 9094

ENTRYPOINT [ "/bin/ladder" ]
CMD        [ "--help"]