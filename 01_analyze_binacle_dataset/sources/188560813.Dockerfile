FROM capitalmatch/haskell-desktop

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl gedit

RUN curl -sL https://deb.nodesource.com/setup | bash - \
    && apt-get install -y nodejs

RUN add-apt-repository -y ppa:webupd8team/sublime-text-2 && \
    apt-get update && \
    apt-get install sublime-text

WORKDIR /home/dockerx

ADD clone-or-pull.sh clone-or-pull.sh

RUN ./clone-or-pull.sh https://github.com/qwaneu/property-based-tutorial joy

RUN cd joy/exercises/js && \
    npm install jsverify && \
    npm install underscore

RUN cd joy/exercises/hsmoney && \
    cabal install --only-dependencies

RUN chown -R dockerx.dockerx joy

