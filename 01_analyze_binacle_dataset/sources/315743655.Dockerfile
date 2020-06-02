FROM appropriate/curl

LABEL version=0.5

COPY ./produce-logs.sh /
WORKDIR /

ENTRYPOINT ["/bin/sh"]
CMD ["./produce-logs.sh"]