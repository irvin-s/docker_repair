FROM node

COPY package.json /app/
WORKDIR /app
RUN npm install

COPY server.js /app/
ADD frunner.proto /app/

CMD ["node","server.js"]
