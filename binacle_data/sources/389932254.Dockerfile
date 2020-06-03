FROM ubuntu:16.04
MAINTAINER Denis Costa

RUN apt update
RUN apt install -y sudo

RUN mkdir -p /src/
WORKDIR /src/
COPY . /src/

RUN bash -c "USER=root HOME=/root DEBUG=1 NO_GPG_VERIFY=1 /src/deploy.sh"
