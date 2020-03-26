FROM inikolaev/alpine-nodejs

RUN npm install -g heroku

ENTRYPOINT ["heroku"]
CMD ["--version"]
