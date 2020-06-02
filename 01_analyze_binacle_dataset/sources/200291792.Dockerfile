FROM debian:stable
LABEL maintainer="git@albertyw.com"
EXPOSE 5003

# Install updates and system packages
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y build-essential curl locales software-properties-common

# Set locale
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV GOPATH /root/gocode

# Set up directory structures
RUN mkdir -p /root/gocode/src/github.com/albertyw/reaction-pics
COPY . /root/gocode/src/github.com/albertyw/reaction-pics
WORKDIR /root/gocode/src/github.com/albertyw/reaction-pics

# App-specific setup
RUN bin/container_setup.sh

CMD ["bin/start.sh"]
