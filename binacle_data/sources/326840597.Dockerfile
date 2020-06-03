FROM node:10.8.0

RUN mkdir -p /opt/app
WORKDIR /opt/app

RUN npm i npm@latest -g

WORKDIR /opt
COPY package.json package-lock.json* ./
RUN npm install && npm cache clean --force
ENV PATH /opt/node_modules/.bin:$PATH

WORKDIR /opt/app
COPY . /opt/app

CMD ["npm", "start"]

EXPOSE 3000