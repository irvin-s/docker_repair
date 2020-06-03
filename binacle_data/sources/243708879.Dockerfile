FROM node:4.6.2

MAINTAINER Jaych Su <jaych.su@autodesk.com>

RUN npm set progress=false \
  && npm install -g --progress=false npm@4.0.2 \
  && npm install -g --progress=false yarn@0.17.10
