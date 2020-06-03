#FROM resin/qemux86-64-node:slim
FROM node:6-slim
RUN apt-get update && apt-get install -y git ssh
RUN npm install git+https://git@github.com/kpavel/openwhisk-light.git pouchdb && npm cache clean && rm -rf /tmp/*
CMD ["sh", "-c", "cd /node_modules/openwhisk-light; npm start"]
