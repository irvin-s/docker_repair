FROM lapp_base:latest

RUN apt-get update && apt-get install -y python-software-properties curl git
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get update && apt-get install -y nodejs

RUN mkdir -p /opt/app

WORKDIR /opt/app
RUN git clone https://github.com/altangent/lightning-viz.git src

WORKDIR /opt/app/src/

RUN npm i
RUN npm run build

CMD lncli --rpcserver lnd:10009 getinfo && npm start
