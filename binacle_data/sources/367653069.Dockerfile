FROM alpine
RUN apk --update add nmap
COPY . /
WORKDIR /
VOLUME ["/nmap-sd"]
ENTRYPOINT ["/entrypoint.sh"]
