FROM node:6.2.2

WORKDIR /app
ADD . /app
RUN npm install
ADD . /app

EXPOSE 5000

CMD node /app/.
