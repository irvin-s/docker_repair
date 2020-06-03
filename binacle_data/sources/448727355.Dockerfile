FROM ubuntu:trusty
MAINTAINER Jeff Lindsay <progrium@gmail.com>

RUN apt-get update && apt-get install -y ruby-dev make
RUN gem install --no-rdoc --no-ri ohai

ADD ./build/ohaithere /bin/ohaithere

USER nobody
EXPOSE 8000

ENTRYPOINT ["/bin/ohaithere"]