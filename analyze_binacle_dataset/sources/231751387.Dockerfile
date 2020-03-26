FROM node:6.9.1

ENV HOME /home/app
RUN mkdir -p /home/app

WORKDIR $HOME

COPY package.json .
COPY tsconfig.json .

RUN npm install

COPY ./src/ ./src/
COPY ./test/ ./test/

CMD ["npm", "run", "test"]
