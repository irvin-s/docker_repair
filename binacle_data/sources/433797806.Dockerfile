FROM nginx
MAINTAINER Akvo Foundation <devops@akvo.org>

ARG LUMEN_KEYCLOAK_URL

RUN apt-get update && \
    apt-get install -y -q --no-install-recommends git curl xz-utils && \
    curl https://nodejs.org/dist/v5.7.0/node-v5.7.0-linux-x64.tar.xz | tar -xJf - --strip-components=1 -C /usr && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN cd /tmp && \
    git clone https://github.com/akvo/akvo-lumen.git && \
    cd akvo-lumen/client && \
    git checkout master && \
    npm set progress=false && \
    npm install && \
    env LUMEN_KEYCLOAK_URL="$LUMEN_KEYCLOAK_URL" npm run build && \
    cp index.html /usr/share/nginx/html && \
    mkdir /usr/share/nginx/html/assets && \
    cp dist/* /usr/share/nginx/html/assets && \
    cd /tmp && rm -rf akvo-lumen

# there is a need to serve always index.html
# https://github.com/akvo/akvo-provisioning/issues/271#issuecomment-191324305
COPY default.conf /etc/nginx/conf.d/default.conf
