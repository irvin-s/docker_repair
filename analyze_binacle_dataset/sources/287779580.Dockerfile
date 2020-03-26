FROM node:8

WORKDIR /home/node/app

ADD ./package.json /home/node/app/package.json
ADD ./src /home/node/app/src
ADD ./test /home/node/app/test
ADD ./.eslintrc.json /home/node/app/.eslintrc.json
ADD ./.prettierrc.json /home/node/app/.prettierrc.json
ADD ./.babelrc /home/node/app/.babelrc
ADD ./index.js /home/node/app/index.js
ADD ./patches /home/node/app/patches

RUN cd /home/node/app && npm install && npm run build

ENTRYPOINT ["npm", "run", "agent"]
