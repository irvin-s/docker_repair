FROM alpine:3.7

RUN apk update && \
    apk add make cmake clang python3 go valgrind cloc
RUN apk add g++  # TODO: remove
COPY . /crystalnet
# ENV CMAKE_C_COMPILER=clang  # TODO: enable
ENV CXX=clang++
WORKDIR /crystalnet
RUN make install && \
    make test && \
    make go_example && \
    make check && \
    cloc src/crystalnet
# TODO: python_example
