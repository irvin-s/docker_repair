FROM haskell:7.8

RUN apt-get update && apt-get install -y libpcre3 libpcre3-dev libmysqlclient-dev
RUN cabal update && cabal install hlint
RUN apt-get install -y curl && \
    curl --silent --location https://deb.nodesource.com/setup_0.12 | bash - && \
    apt-get install -y nodejs build-essential

VOLUME /livelog
WORKDIR /livelog
EXPOSE 3000
