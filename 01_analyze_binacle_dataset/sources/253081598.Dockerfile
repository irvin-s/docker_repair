FROM scgmlz/bornagain-dev:xenial
RUN apt install libqt5svg5-dev

ADD . /source
WORKDIR /source
