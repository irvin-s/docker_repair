# For Emacs 24.x
FROM ubuntu:zesty

USER root

RUN apt-get update \
    && apt-get install -y build-essential \
    && apt-get install --no-install-suggests --no-install-recommends -y emacs24-nox \
    && apt-get install -y ghc \
    && apt-get install -y haskell-stack

WORKDIR /root/haskell-mode

CMD [ "make", "check" ]
