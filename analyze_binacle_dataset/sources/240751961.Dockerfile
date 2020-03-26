FROM mhart/alpine-node:10

WORKDIR /usr/src/app

COPY . .
COPY custom-entrypoint.sh /usr/local/bin/custom-entrypoint.sh

RUN chmod 755 /usr/local/bin/custom-entrypoint.sh && \
    addgroup auth && \
    adduser -D -H -G auth auth && \
    apk add --update --no-cache bash && \
    npm i && \
    npm run build && \
    npm i --production

USER auth

ENTRYPOINT ["/usr/local/bin/custom-entrypoint.sh"]
CMD ["npm", "run", "serve"]
