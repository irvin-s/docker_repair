FROM hypriot/rpi-alpine-scratch
MAINTAINER Daniel S.

RUN apk update && apk upgrade && apk add bash samba-common-tools samba && rm -rf /var/cache/apk/*

COPY run.sh /run.sh
RUN chmod u+x /run.sh

EXPOSE 445 137 138 139

ENTRYPOINT ["/run.sh"]
CMD ["-h"]
