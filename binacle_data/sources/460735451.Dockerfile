FROM ubuntu
RUN apt-get update;apt-get install -y nodejs npm
EXPOSE 1880
ENV PORT 1880
ADD node_modules.tar /
CMD nodejs /node_modules/node-red/red.js
