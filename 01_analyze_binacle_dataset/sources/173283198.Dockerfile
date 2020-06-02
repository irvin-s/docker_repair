FROM mhart/alpine-iojs:2.3.4
MAINTAINER the native web <hello@thenativeweb.io>

# This is run from within the testBox directory.
ADD ./app.js /app.js
ADD ./toBeAdded /toBeAdded

CMD [ "node", "/app.js" ]
