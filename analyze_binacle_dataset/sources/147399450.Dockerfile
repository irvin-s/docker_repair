FROM node:11-alpine
LABEL maintainer="Ocean Protocol <devops@oceanprotocol.com>"

RUN apk add --no-cache --update\
    bash\
    g++\
    gcc\
    git\
    gettext\
    make\
    python

COPY . /app/frontend
WORKDIR /app/frontend

RUN npm install -g npm serve
RUN npm install
RUN npm run build

# Default ENV values
ENV LISTEN_ADDRESS='0.0.0.0'
ENV LISTEN_PORT='3000'

ENTRYPOINT ["/app/frontend/scripts/docker-entrypoint.sh"]

