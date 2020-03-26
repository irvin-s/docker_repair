FROM node:8.9.0-alpine

# install packages
RUN apk update && apk add curl

# install fixuid
RUN USER=node && \
    GROUP=node && \
    curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.2/fixuid-0.2-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
    chown root:root /usr/local/bin/fixuid && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -p /etc/fixuid && \
    printf "user: $USER\ngroup: $GROUP\n" > /etc/fixuid/config.yml

# set entrypoint and command
ENTRYPOINT ["fixuid"]
CMD ["app-run"]

# setup cache dir
RUN mkdir -p /home/node/.cache && \
    chown node:node /home/node/.cache

# copy staged files
COPY stage/ /

# set user
USER node:node
