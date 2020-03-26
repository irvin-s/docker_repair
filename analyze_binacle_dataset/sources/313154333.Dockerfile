#for RaspberryPi
FROM iofog/nodejs-arm

COPY . /src
RUN cd /src; npm install

CMD ["node","/src/openWeatherMap.js"]
