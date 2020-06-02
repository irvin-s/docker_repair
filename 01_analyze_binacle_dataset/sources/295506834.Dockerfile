FROM node:8.11.3-alpine

# install packages
RUN apk update && apk add curl

# install fixuid
RUN curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.4/fixuid-0.4-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
    chown root:root /usr/local/bin/fixuid && \
    chmod 4755 /usr/local/bin/fixuid

# set entrypoint and command
ENTRYPOINT ["fixuid"]
CMD ["app-run"]

# setup cache dir
RUN mkdir -p /ui/node_modules && \
    chown -R node:node /ui && \
    mkdir -p /home/node/.cache/yarn && \
    chown -R node:node /home/node/.cache

# copy staged files
COPY stage/ /

# set user
USER node:node
