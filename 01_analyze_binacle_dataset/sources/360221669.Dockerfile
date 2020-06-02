FROM node:4.2

RUN mkdir -p /app
WORKDIR /app

# Copy package.json separately so it's recreated when package.json
# changes.
COPY package.json ./package.json
RUN npm -q install
COPY . /app
RUN npm -q install -g phantomjs bower ember-cli; bower --allow-root install

EXPOSE 4200
EXPOSE 49152

CMD [ "ember", "server" ]
