FROM node
MAINTAINER wyvernnot <wyvernnot@gmail.com>
COPY . .
RUN npm install
EXPOSE 3000
CMD ["npm","run-script","start"]