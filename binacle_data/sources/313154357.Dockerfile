FROM iofog/nodejs
#for RaspberryPi
#FROM iofog/nodejs-arm

COPY index.js /src/index.js
COPY package.json /src/package.json
RUN cd /src; npm install

CMD [ "node", "/src/index.js" ]
