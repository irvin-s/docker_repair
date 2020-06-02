FROM haskell:8.2.1

WORKDIR /usr/src/app
COPY ./stack.yaml .
COPY ./package.yaml .

RUN apt-get update && apt-get install -y libleveldb-dev leveldb-doc openssh-client expat libexpat1-dev libpq-dev
RUN stack upgrade
RUN apt-get install -y xz-utils make
RUN stack install --no-docker --only-dependencies -j2 --system-ghc
COPY . .
RUN stack install --no-docker --system-ghc
# delete .git after building uplink for a smaller image
RUN rm -rf .git/
