FROM iron/node:latest

ADD server.js /server.js

EXPOSE 8000
CMD    ["node", "/server.js"]
