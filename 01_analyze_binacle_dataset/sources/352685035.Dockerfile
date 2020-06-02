FROM python:3-slim
MAINTAINER "Dan Isla <dan.isla@gmail.com>"

RUN apt-get update && apt-get install -y --no-install-recommends \
    rtmpdump \
  && apt-get clean

RUN pip3 install livestreamer

ENTRYPOINT ["livestreamer", "--player-external-http", "--player-external-http-port=8000", "--yes-run-as-root", "--default-stream=best"]
