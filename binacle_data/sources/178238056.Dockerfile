FROM alpine:latest
LABEL maintainer="Odd E. Ebbesen <oddebb@gmail.com>"

RUN addgroup -g 1000 grip && adduser -u 1000 -G grip -D grip
RUN apk add --no-cache --update \
		ca-certificates \
		py-pip \
		tini \
		&& \
		rm -rf /var/cache/apk/*

RUN pip install grip
ENV GRIPHOME=/src
RUN mkdir ${GRIPHOME} && chown grip:grip ${GRIPHOME}
USER grip
WORKDIR ${GRIPHOME}
VOLUME ${GRIPHOME}

ENTRYPOINT ["tini", "-g", "--", "grip"]
CMD ["--help"]
