#FROM node:6-alpine
FROM resin/qemux86-64-node:slim
RUN apt-get update && apt-get install -y git ssh
#RUN npm install git+https://git@github.com/kpavel/openwhisk-light.git pouchdb && npm cache clean && rm -rf /tmp/*
ADD node_modules /node_modules
ADD package.json *.js /
ADD routes /routes
#CMD ["sh", "-c", "cd /node_modules/openwhisk-light; npm start"]
CMD ["sh", "-c", "cd /; echo IN CMD; npm rebuild; npm start"]
