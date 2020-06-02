FROM node:6.5.0

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json /usr/src/app/
COPY . /usr/src/app

EXPOSE 3000

# Install PDF Toolkit. Required for PDF compression.
ENV PDFTK_VERSION 2.02

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y gcj-4.8-jdk g++-4.8 unzip build-essential && \
    apt-get clean

ADD https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/pdftk-${PDFTK_VERSION}-src.zip /tmp/
RUN unzip /tmp/pdftk-${PDFTK_VERSION}-src.zip -d /tmp && \
    sed -i 's/VERSUFF=-4.6/VERSUFF=-4.8/g' /tmp/pdftk-${PDFTK_VERSION}-dist/pdftk/Makefile.Debian && \
    cd /tmp/pdftk-${PDFTK_VERSION}-dist/pdftk && \
    make -f Makefile.Debian && \
    make -f Makefile.Debian install && \
    rm -Rf /tmp/pdftk-*

CMD npm install && npm start