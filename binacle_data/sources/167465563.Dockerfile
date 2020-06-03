FROM node:0.10

ADD package.json /code/
WORKDIR /code
RUN npm install
ADD . /code

CMD ["./node_modules/strongloop/bin/slc", "run"]