FROM        node:0.10.36
MAINTAINER  Oleg Grenrus <oleg.grenrus@futurice.com>

# Dependencies
COPY        package.json /tyckiting-client/
WORKDIR     /tyckiting-client
RUN         npm install

# Everything else
COPY        . /tyckiting-client

# Start
ENTRYPOINT  node /tyckiting-client/cli.js --host $GAMESERVER_PORT_3000_TCP_ADDR --port $GAMESERVER_PORT_3000_TCP_PORT --ai dummy --teamname "Vanilla Dummy"
