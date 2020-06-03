# You must be in the root directory of this project when building this image
FROM node:5.9.0

WORKDIR /tmp
COPY submit-code-service/package.json /tmp/
RUN npm config set registry http://registry.npmjs.org/ && npm install -q --production

WORKDIR /usr/src/app
COPY stylechecker/src/main/proto/ /usr/src/app/stylechecker/src/main/proto/
COPY submit-code-service/ /usr/src/app/submit-code-service
RUN cp -a /tmp/node_modules /usr/src/app/submit-code-service

WORKDIR /usr/src/app/submit-code-service
RUN npm run build

ENV NODE_ENV=production 
ENV PORT=50052

CMD [ "/usr/local/bin/npm", "run", "start" ]

EXPOSE 50052