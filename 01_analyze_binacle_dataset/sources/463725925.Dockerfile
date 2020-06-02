FROM debian:stable as tools

# Put this first to recompute this layer less frequently
# as it is pretty slow
RUN apt-get update && apt-get -y --no-install-recommends install openssl
RUN openssl dhparam -out /dhparam.pem 2048

RUN apt-get update && apt-get -y --no-install-recommends install \
  wget ca-certificates git

RUN \
  wget -O /usr/local/bin/dumb-init \
  https://github.com/Yelp/dumb-init/releases/download/v1.2.1/dumb-init_1.2.1_amd64 && \
  echo "057ecd4ac1d3c3be31f82fc0848bf77b1326a975b4f8423fe31607205a0fe945 /usr/local/bin/dumb-init" | \
    sha256sum -c - && \
  chmod 755 /usr/local/bin/dumb-init

RUN cd /tmp && \
  git clone https://github.com/mrako/wait-for.git && \
  cd wait-for && \
  git checkout d9699cb9fe8a4622f05c4ee32adf2fd93239d005 && \
  cp -v wait-for /bin/ && \
  cd /tmp && \
  rm -r /tmp/wait-for


FROM node:10-alpine as frontpage

ARG WEBPACK_MODE=production
RUN mkdir /root/html
WORKDIR /root/html
COPY websites/frontpage/package.json ./
COPY websites/frontpage/yarn.lock ./
RUN yarn install --network-timeout 100000
COPY websites/frontpage/src ./src
COPY websites/frontpage/static ./static
COPY websites/frontpage/webpack.config.js ./
RUN rm -f ./src/README.md
COPY README.md ./src/README.md
RUN npx webpack --mode=$WEBPACK_MODE


FROM node:10-alpine as auditpage

ARG WEBPACK_MODE=production
RUN mkdir /root/html
WORKDIR /root/html
COPY websites/audit/package.json ./
COPY websites/audit/yarn.lock ./
RUN yarn install --network-timeout 100000
COPY websites/audit/src ./src
COPY websites/audit/.babelrc ./
COPY websites/audit/webpack.config.js ./
RUN npx webpack --mode=$WEBPACK_MODE


FROM nginx:stable

RUN apt-get update && \
  apt-get -y --no-install-recommends install inotify-tools

VOLUME /etc/nginx/certs

WORKDIR /root
COPY services/nginx/start.sh ./
COPY services/nginx/nginx-template.conf /etc/nginx/nginx-template.conf
COPY services/nginx/blacklist.txt /etc/nginx/blacklist.txt

RUN rm -rf /var/www/ && mkdir /var/www
COPY --from=tools /dhparam.pem /etc/nginx/dhparam.pem
COPY --from=tools /usr/local/bin/dumb-init /usr/local/bin/dumb-init
COPY --from=tools /bin/wait-for /bin/wait-for
COPY --from=frontpage /root/html/dist /var/www/static
COPY --from=auditpage /root/html/dist/index.html /var/www/static/audit.html

VOLUME /var/log/dapps.earth-integrity

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
CMD ["./start.sh"]
