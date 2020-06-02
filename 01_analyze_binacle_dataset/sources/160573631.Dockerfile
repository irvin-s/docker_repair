FROM node:8

RUN npm install -g grunt-cli && \
    echo '{ "allow_root": true }' > /root/.bowerrc

COPY . /usr/src/dative
ENV GIT_DIR=/usr/src/dative

WORKDIR /usr/src/dative/
RUN yarn
WORKDIR /usr/src/dative/test/
RUN yarn

WORKDIR /usr/src/dative/
CMD grunt serve
