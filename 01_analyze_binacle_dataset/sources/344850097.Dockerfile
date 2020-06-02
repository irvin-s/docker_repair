FROM ubuntu:xenial

RUN apt-get update
RUN apt-get install -y gcc
RUN apt-get install -y g++
RUN apt-get install -y build-essential libtcmalloc-minimal4 && ln -s /usr/lib/libtcmalloc_minimal.so.4 /usr/lib/libtcmalloc_minimal.so
RUN apt-get install -y libboost-all-dev
RUN apt-get install -y cmake

ENV APP_DIRECTORY /app/

WORKDIR ${APP_DIRECTORY}
COPY ./ ${APP_DIRECTORY}

RUN ./compile.sh

EXPOSE 8080/tcp
WORKDIR ${APP_DIRECTORY}
ENTRYPOINT ["./build/src/example"]