FROM alpine:3.7 AS base
WORKDIR /src
RUN apk --update add alpine-sdk bash ninja linux-headers cmake
COPY . ./
WORKDIR /src/build
RUN cmake .. -GNinja -DCMAKE_BUILD_TYPE=Debug -DBUILD_TESTING=ON
RUN ninja
RUN ctest
