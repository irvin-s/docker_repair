FROM node:10-stretch AS builder

# tools
RUN echo "deb http://ftp.debian.org/debian stretch-backports main" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y zopfli && \
    apt-get install -y -t stretch-backports brotli && \
    rm -rf /var/lib/apt/lists/*

# some bower components expect that bower is installed
RUN npm install -g bower

# working directory
RUN mkdir -p /project && \
    chown node /project
WORKDIR /project
USER node

# cache node_modules
COPY --chown=node package.json yarn.lock /project/
RUN yarn install --frozen-lockfile --non-interactive --no-progress && \
    yarn cache clean && \
    bower cache clean
LABEL cache-this-layer=liipi-web-builder-cache

# do the build
COPY --chown=node *.* /project/
COPY --chown=node karma /project/karma/
COPY --chown=node src /project/src/
RUN yarn run build

# offline compress static resources
RUN find /project/bin/static -type f -regextype posix-extended \
        -iregex '.*\.(html?|js|css|svg|otf|ttf|txt|json)' \
        -exec zopfli '{}' \; \
        -exec brotli --best '{}' \;

# ------------------------------------------------------------

FROM nginx:1.15.2 AS nginx-builder

# Add brotli module to nginx. Based on the article
# https://www.fastfwd.com/improve-http-compression-with-brotli/
# and the Dockerfile of our parent image.
RUN set -x && \
    # save list of currently installed packages so build dependencies can be cleanly removed later
    savedAptMark="$(apt-mark showmanual)" && \
    \
    # tools and source repos
    apt-get update && \
    apt-get install -y apt-transport-https git && \
    echo "deb https://nginx.org/packages/mainline/debian/ stretch nginx" >> /etc/apt/sources.list.d/nginx.list && \
    echo "deb-src https://nginx.org/packages/mainline/debian/ stretch nginx" >> /etc/apt/sources.list.d/nginx.list && \
    apt-get update && \
    \
    # get ngx_brotli sources
    cd /usr/local/src/ && \
    git clone https://github.com/google/ngx_brotli.git && \
    cd /usr/local/src/ngx_brotli/ && \
    git submodule update --init --recursive && \
    \
    # get nginx sources
    mkdir -p /tmp/nginx-build && \
    cd /tmp/nginx-build && \
    apt-get build-dep -y nginx=${NGINX_VERSION} && \
    apt-get source nginx=${NGINX_VERSION} && \
    \
    # build nginx
    cd /tmp/nginx-build/nginx-* && \
    configureArgs=$(nginx -V 2>&1 | sed -n -e 's/^configure arguments: //p') && \
    eval "./configure ${configureArgs} --add-module=/usr/local/src/ngx_brotli" && \
    make && \
    make install && \
    \
    # reset apt-mark's "manual" list so that "purge --auto-remove" will remove all build dependencies
    apt-mark showmanual | xargs apt-mark auto > /dev/null && \
    apt-mark manual $savedAptMark && \
    \
    # cleanup
    apt-get purge --auto-remove -y && \
    rm -rf /usr/local/src/ngx_brotli/   \
           /tmp/nginx-build/            \
           /var/lib/apt/lists/*         \
           /etc/apt/sources.list.d/nginx.list
LABEL cache-this-layer=liipi-web-nginx-builder-cache

# ------------------------------------------------------------

FROM nginx:1.15.2

COPY --from=nginx-builder /usr/sbin/nginx /usr/sbin/nginx

COPY docker/nginx-default.conf.template /etc/nginx/conf.d/default.conf.template

COPY docker/docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]

COPY --from=builder /project/bin/static /usr/share/nginx/html
