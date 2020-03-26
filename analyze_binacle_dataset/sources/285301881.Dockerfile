FROM node:7
WORKDIR /app
COPY package.json /app
RUN npm install
COPY . /app
RUN npm run build
RUN npm install http-server -g
CMD http-server ./
EXPOSE 8080
