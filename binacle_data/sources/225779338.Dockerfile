FROM debian:jessie

RUN apt-get update && apt-get install -y curl build-essential

ENV BEANSTALKD_VERSION 1.10
RUN curl -sL https://github.com/kr/beanstalkd/archive/v${BEANSTALKD_VERSION}.tar.gz | tar xvz -C /tmp

# build and install
RUN cd /tmp/beanstalkd-${BEANSTALKD_VERSION}\
  && make\
  && cp beanstalkd /usr/bin

RUN apt-get remove -y --purge build-essential curl
RUN apt-get autoremove -y && apt-get clean

EXPOSE 11300
CMD ["beanstalkd", "-p", "11300"]
