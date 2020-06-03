FROM ubuntu:17.10
MAINTAINER Martin Muellenhaupt "mm+fafsdpserver@netlair.de"

RUN apt-get update && apt-get install -y qtbase5-dev ninja-build libjsoncpp-dev cmake g++ git pkg-config

RUN git clone https://github.com/FAForever/ice-adapter.git && \
    mkdir build && \
    cd build && \
    cmake -G "Ninja" ../ice-adapter/legacy_testclient && \
    ninja faf-ice-legacy-testserver

EXPOSE 54321
ENTRYPOINT ["build/faf-ice-legacy-testserver"]
