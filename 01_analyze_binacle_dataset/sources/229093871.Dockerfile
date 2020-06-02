FROM kkarczmarczyk/node-yarn:7.6
MAINTAINER i@cdog.me

ENV WD /proj

RUN mkdir -p $WD
WORKDIR $WD


COPY package.json $WD/
COPY yarn.lock $WD/
RUN yarn

COPY . $WD/
RUN yarn build
CMD ["yarn", "start"]
