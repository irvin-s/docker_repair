FROM mhart/alpine-iojs:2.3.4
MAINTAINER the native web <hello@thenativeweb.io>

# This is run from within the testBox directory.
ADD ./non-existent.js /app.js

CMD [ "node", "/app.js" ]
