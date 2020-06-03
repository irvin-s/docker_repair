FROM iofog/nodejs

COPY . /src
RUN cd /src; npm install

CMD ["node","/src/openWeatherMap.js"]
