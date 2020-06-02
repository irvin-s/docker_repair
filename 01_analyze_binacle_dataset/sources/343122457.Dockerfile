FROM alpine

RUN apk add --no-cache gcc make musl-dev zlib-dev ucl-dev git g++ perl bash

WORKDIR /tmp

RUN git clone -b devel --depth=1 --recurse-submodules https://github.com/upx/upx && \
    make -C upx -j all && \
    install -m 755 upx/src/upx.out /usr/local/bin/upx && \
    rm -rf upx

COPY . .
RUN make && upx donkey

CMD cat donkey
