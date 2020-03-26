FROM node:10-stretch-slim

MAINTAINER Robert Wimmer <docker@tauceti.net>

# Run tasks as unpriviledged user
USER node

# Change to $HOME as defined in node:8.2-alpine image
WORKDIR /home/node

# Install app dependencies
RUN npm install chromeless
RUN npm install express

# Webserver is listening on port ...
EXPOSE 3000

# Copy scraping script
COPY pinlinkfetcher.js /home/node/pinlinkfetcher.js

# Start webserver
ENTRYPOINT ["node", "pinlinkfetcher.js"]
CMD ["-h"]
