FROM node:6.9.5-alpine as builder
COPY . /usr/src/nelson.gui

WORKDIR /usr/src/nelson.gui
RUN npm install -g yarn \
    && yarn install --pure-lockfile \
    && yarn run build:all \
    && npm install -g . \
    && npm uninstall -g yarn

FROM node:6.9.5-alpine
COPY --from=builder /usr/local/bin /usr/local/bin
COPY --from=builder /usr/local/lib/node_modules /usr/local/lib/node_modules

EXPOSE 5000

CMD ["/usr/local/bin/nelson.gui"]
ENTRYPOINT ["/usr/local/bin/nelson.gui"]
