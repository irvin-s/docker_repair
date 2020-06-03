FROM ubuntu:16.04
MAINTAINER epheo <github@epheo.eu>

RUN apt update && apt install -y netcat

EXPOSE 1235

CMD ["env"]
