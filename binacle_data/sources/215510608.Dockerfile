FROM node:10

ARG NODE_ENV
ENV NODE_ENV $NODE_ENV

WORKDIR /kansa
COPY server/package.json .
COPY common/package.json ./common/
RUN npm install && \
    npm install ./common && \
    npm cache clean --force

COPY modules/raami/package.json modules/raami/
RUN cd modules/raami && npm install && npm cache clean --force

COPY modules/slack/package.json modules/slack/
RUN cd modules/slack && npm install && npm cache clean --force

COPY common ./common
COPY modules ./modules
COPY server .

EXPOSE 80
CMD [ "npm", "start" ]
