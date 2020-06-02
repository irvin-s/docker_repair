FROM node:8

COPY server.js /var/www/node/

CMD ["node", "/var/www/node/server.js"]