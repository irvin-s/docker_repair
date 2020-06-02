FROM node:8-alpine
RUN adduser -D dos && mkdir /app && chown -R dos /app
USER dos
WORKDIR  /app
COPY . .
RUN yarn
EXPOSE 3000
CMD ["yarn", "start"]
