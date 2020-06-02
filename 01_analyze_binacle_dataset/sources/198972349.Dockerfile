FROM        node:5.5.0
MAINTAINER  Jukka Viinamäki <jukka.viinamaki@futurice.com>

# Server uses only one port
EXPOSE      3000

# Start
ENTRYPOINT  [ "node", "/tyckiting-server/start-server.js" ]

# Dependencies
COPY        package.json /tyckiting-server/
WORKDIR     /tyckiting-server
RUN         npm install

# Everything else
COPY        . /tyckiting-server
RUN         make
