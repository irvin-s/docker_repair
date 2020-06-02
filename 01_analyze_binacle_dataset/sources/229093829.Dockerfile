FROM node:7.6
ENV WD /proj
ENV APP_PORT 2333
RUN mkdir -p $WD
WORKDIR $WD
EXPOSE $APP_PORT
COPY . $WD/

CMD ["node", "app.js"]