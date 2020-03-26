FROM golang:1.6-wheezy

RUN curl -sL https://deb.nodesource.com/setup_0.12 | bash -
RUN apt-get  --yes --quiet install --no-install-recommends\
	nodejs \
 	npm \
    && rm -rf /var/lib/apt/lists/* \
    && npm install -g bower

RUN go get github.com/mholt/caddy

ADD . /site
WORKDIR /site

RUN bower install --allow-root

EXPOSE 2015
CMD ["caddy"]
