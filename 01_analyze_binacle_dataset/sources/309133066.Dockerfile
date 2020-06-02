FROM node:8.11.4-slim

RUN npm install -g homeeup

EXPOSE 2001

CMD ["/usr/local/bin/homeeup"]

