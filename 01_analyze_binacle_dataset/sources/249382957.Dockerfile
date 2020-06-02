FROM node:8

ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH=$PATH:/home/node/.npm-global/bin

USER node
RUN npm i -g serverless 
RUN npm i -g serverless-artillery
