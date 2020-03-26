# vidi-dashboard
FROM node:4


RUN mkdir /src
ADD package.json /src/

WORKDIR /src

RUN npm install

COPY . /src

RUN npm run build

EXPOSE 3000

CMD ["node", "-r toolbag", "server/start.js", "--seneca.options.tag=vidi-dashboard", "--seneca-log=type:act"]
