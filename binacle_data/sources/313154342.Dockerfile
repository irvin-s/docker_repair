FROM iofog/nodejs

COPY . /src
RUN cd /src; npm install

CMD ["node","/src/tempConversion.js"]