FROM alpine:3.2
MAINTAINER Ivan Pedrazas <ipedrazas@gmail.com>

RUN apk add --update \
      python \
      py-pip \
      jq \
      curl \
      bash && \
      pip install requests

COPY src /app


CMD [ "python", "/app/app.py" ]
