FROM mhart/alpine-node:0.10.39

WORKDIR /src

ADD package.json /src/
RUN npm install --production

ADD . /src

ENTRYPOINT ["bin/udp-portal"]
