FROM alpine:latest
MAINTAINER playniuniu@gmail.com

RUN apk --no-cache --update add xeyes

CMD ["xeyes"]
