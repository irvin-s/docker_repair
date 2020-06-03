FROM node:7.7
MAINTAINER @qxip (twitter)
RUN git clone https://github.com/sipcapture/hepgen.js.git
WORKDIR hepgen.js
RUN npm install
ENTRYPOINT node hepgen.js