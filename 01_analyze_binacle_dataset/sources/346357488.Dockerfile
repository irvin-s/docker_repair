FROM mhart/alpine-node
RUN mkdir -p /code
ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN cp -a /tmp/node_modules /code
RUN npm install express
RUN npm install deepstream.io-client-js
WORKDIR /code
ADD . /code
CMD ["npm","start"]
