# Use Ubuntu 16.04 LTS server image as the base
FROM binarydev/docker-ubuntu-with-xvfb:latest

RUN apt-get install --fix-missing -y unzip

EXPOSE 80

ENV NVM_DIR /root/.nvm
ENV NODE_VERSION 8.10.0

COPY server.js package.json start.sh /app/

WORKDIR /app

# INSTALL NVM and NODE 4.4.4 LTS - Since each RUN executes within its own image,
# this all needs to happen within the same image to maintain ENV vars
RUN git clone https://github.com/creationix/nvm.git $NVM_DIR && \
    cd $NVM_DIR && \
    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" origin` && \
    . "$NVM_DIR/nvm.sh" && \
    nvm install $NODE_VERSION && \
    echo "export NVM_DIR=\"/root/.nvm\" \n \n [ -s \"\$NVM_DIR/nvm.sh\" ] && . \"\$NVM_DIR/nvm.sh\"" >> "/root/.bashrc" && \
    cd /app && \
    npm install

ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH


RUN chmod a+x start.sh

CMD ./start.sh
