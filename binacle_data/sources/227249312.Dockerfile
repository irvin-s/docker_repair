FROM node:4.4-onbuild
EXPOSE 1208
RUN npm install -g forever
ENTRYPOINT forever --spinSleepTime 1000 --minUptime 1000 index.js