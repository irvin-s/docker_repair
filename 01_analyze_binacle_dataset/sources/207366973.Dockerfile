FROM node
RUN npm install -g babel
RUN npm install -g webpack

ENV NODE_ENV=production
ENV PORT=80

ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN mkdir -p /app && cp -a /tmp/node_modules /app/

WORKDIR /app
ADD . /app
RUN cp -R client/lib/aframe node_modules/

RUN webpack

EXPOSE 80
CMD ["npm", "run", "docker-start"]
