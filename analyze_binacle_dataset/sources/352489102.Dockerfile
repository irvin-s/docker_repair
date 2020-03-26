FROM alpine

RUN apk add --no-cache --update privoxy

RUN sed -i -e '/^listen-address/s/127.0.0.1/0.0.0.0/' \
	   -e '/^accept-intercepted-requests/s/0/1/' \
	   -e '/^enforce-blocks/s/0/1/' \
	   -e '/^#debug/s/#//' /etc/privoxy/config


USER privoxy
EXPOSE 8118

CMD ["privoxy", "--no-daemon", "/etc/privoxy/config"]
