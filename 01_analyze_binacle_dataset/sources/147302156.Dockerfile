FROM ubuntu:16.04

RUN apt update
RUN apt install -y curl
RUN curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt install -y build-essential libssl-dev net-tools vim
RUN apt install -y gcc g++ make
RUN apt install -y nodejs

# Create app directory
WORKDIR /opt/

COPY package*.json ./
COPY . .

EXPOSE 8081

RUN useradd -ms /bin/bash node
RUN chown -R node:node /opt/

RUN npm install
RUN npm install -g nodemon

USER node

CMD ["nodemon", "start"]
