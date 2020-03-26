FROM debian:stretch

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y curl unzip git build-essential git jq && \
    curl -sL https://deb.nodesource.com/setup_9.x | bash - && \
    apt-get install -y nodejs

EXPOSE 10010
CMD [ "npm", "start" ]

WORKDIR /app
COPY package.json /app/
RUN npm install

COPY . /app/
