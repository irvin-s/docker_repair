FROM node:7.6
ENV WD /proj
ENV APP_PORT 12530
ENV APP_ENV staging
RUN mkdir -p $WD
WORKDIR $WD
EXPOSE $APP_PORT
COPY . $WD/
RUN cd $WD/ && pwd
RUN npm install
RUN npm run del && npm run build

CMD ["npm", "run","serve"]