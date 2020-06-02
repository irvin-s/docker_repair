FROM node:4.2

RUN mkdir -p /app
WORKDIR /app

# Copy package.json separately so it's recreated when package.json
# changes.
COPY package.json ./package.json
RUN npm -q install
COPY . /app

EXPOSE 3000

CMD [ "npm", "start" ]
