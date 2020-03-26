FROM cloudron/base:0.3.3
MAINTAINER iao@iki.fi <iao@iki.fi>

ENV DEBIAN_FRONTEND noninteractive

# Replace shell with bash so we can source files (required for nvm)
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV NVM_DIR /usr/local/nvm

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.25.4/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install iojs-v2.5.0 \
    && nvm alias default iojs-v2.5.0 \
    && nvm use default

ENV PATH $NVM_DIR/versions/io.js/v2.5.0/bin:$PATH

RUN npm install -g ember-cli

ADD . /app/code
RUN mkdir /app/code/logs /app/code/run

WORKDIR /app/code
RUN npm install
RUN gulp build-pages

WORKDIR /app/code/client
RUN npm install
RUN ember build

EXPOSE 3200

WORKDIR /app/code
CMD [ "/app/code/cloudron/start.sh" ]
