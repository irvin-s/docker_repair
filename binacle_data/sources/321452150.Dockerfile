
FROM keymetrics/pm2:latest-alpine
WORKDIR /app
VOLUME ["/app/api/data"]
COPY .babelrc .eslintignore .eslintrc.js .postcssrc.js .stylintrc /app/
COPY src /app/src
COPY api /app/api
COPY config /app/config
COPY package.json package-lock.json quasar.conf.js server.js ecosystem.config.js /app/
COPY docker-start.sh /app/docker-start.sh

ENV NPM_CONFIG_LOGLEVEL warn
ENV IS_PRIVATE_PORTAL false
ENV REQUIRES_INVITE false
ENV ADMIN_EMAIL "sue@sixpack.com"

# Install app dependencies
RUN npm i -g quasar-cli
RUN ls -lt
RUN npm install
RUN quasar build
RUN echo "Done with Client"

EXPOSE 80
CMD [ "sh", "docker-start.sh" ]