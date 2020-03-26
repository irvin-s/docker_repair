FROM node:4.4.3-slim

COPY package.json /src/
WORKDIR /src/
RUN npm install -g sails
RUN npm install

ADD . /src/

RUN wget -O /wait-for-it.sh https://raw.githubusercontent.com/iturgeon/wait-for-it/8f52a814ef0cc70820b87fbf888273f3aa7f5a9b/wait-for-it.sh \
  && chmod +x /wait-for-it.sh

EXPOSE 80
CMD sh -c '/wait-for-it.sh -t 100 edr-db:5432 && sails lift'
