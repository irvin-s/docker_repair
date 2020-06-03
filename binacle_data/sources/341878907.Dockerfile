FROM node:8-alpine
RUN adduser -D dos && mkdir /config && chown -R dos /config
USER dos
WORKDIR /config
COPY . .
RUN yarn 
EXPOSE 3002
CMD [ "yarn", "migrate-prod" ]
CMD ["yarn", "start"]
