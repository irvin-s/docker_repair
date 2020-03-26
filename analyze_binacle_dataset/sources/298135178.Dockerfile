FROM node:6.3

ENV NPM_CONFIG_LOGLEVEL warn

#Run our code in a separate folder as you would on your machine
RUN mkdir -p /home/nodeEx/code

#Default NODE_ENV is production
ARG NODE_ENV=production
ENV NODE_ENV $NODE_ENV

#Change to the dir where we will deploy our code
WORKDIR /home/nodeEx/code

COPY package.json .

RUN npm install

ENV PATH /home/nodeEx/code/node_modules/.bin:$PATH

COPY . .

EXPOSE 3000

CMD ["npm", "start"]