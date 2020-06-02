FROM ubuntu:16.04

# Create app directory
WORKDIR /root

ENV NODE_VERSION 6

# Install dependencies
RUN apt-get update
RUN apt-get install \
    apt-transport-https\
    ca-certificates \
    libssl-dev \
    git\
    curl\
    vim\
    nodejs\
    gcc\
    build-essential\
    make\
    nginx\
    psmisc\
    mongodb\
    python\
    -y -q --no-install-recommends

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.1/install.sh | bash && \
    . /root/.bashrc && \
    nvm install $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    nvm use default

COPY . /root/venue

# Create mongodb data directory
RUN mkdir -p /data/db

# Configure nginx
RUN /root/venue/scripts/docker/configure-path

RUN . /root/.bashrc && \
    cd venue && \
    npm install -g gulp-cli && \
    npm install

RUN apt-get clean

EXPOSE 80 443 27017 3000
CMD ["/root/venue/scripts/docker/init-docker"]
