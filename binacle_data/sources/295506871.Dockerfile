FROM node:8.9.0-alpine

# set pwd, ports, user, command
WORKDIR /ui
EXPOSE 4000
CMD ["node", "server.js"]

# copy application files
COPY stage/ /

# change ownership application files
RUN chown -R node:node /ui

# set user
USER node:node
