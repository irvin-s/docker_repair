FROM mitchty/alpine-ghc:latest

MAINTAINER Nikyle Nguyen <NLKNguyen@MSN.com>

RUN apk add --no-cache build-base git


RUN mkdir -p /usr/src/shellcheck
WORKDIR /usr/src/shellcheck

RUN git clone https://github.com/koalaman/shellcheck .
RUN cabal update && cabal install

ENV PATH="/root/.cabal/bin:$PATH"


# Get shellcheck binary
RUN mkdir -p /package/bin/
RUN cp $(which shellcheck) /package/bin/

# Get shared libraries
RUN mkdir -p /package/lib/
RUN ldd $(which shellcheck) | grep "=> /" | awk '{print $3}' | xargs -I '{}' cp -v '{}' /package/lib/


# Copy shellcheck package out to mounted directory
CMD ["cp", "-avr", "/package", "/mnt/"]
