FROM node:5.6.0

RUN mkdir -p /opt/app-review-monitor/src
WORKDIR /opt/app-review-monitor

COPY .babelrc /opt/app-review-monitor/
COPY ./package.json /opt/app-review-monitor/package.json
RUN npm install

COPY ./src /opt/app-review-monitor/src/
RUN npm run build

# Set development environment as default
ENV NODE_ENV development
ENV NODE_PORT 9001

EXPOSE 9001

CMD ["node", "dist/app.js"]