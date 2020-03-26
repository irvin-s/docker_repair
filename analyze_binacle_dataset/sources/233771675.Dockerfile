FROM node:6-slim

RUN npm i -g list

EXPOSE 3000

CMD ["list", "/usr/src"]