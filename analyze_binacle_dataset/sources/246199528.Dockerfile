FROM node:6.9
COPY server.js /
ENTRYPOINT ["node", "/server.js"]
EXPOSE 8080