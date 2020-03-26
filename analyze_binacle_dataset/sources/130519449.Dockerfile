FROM shykes/nodejs
MAINTAINER James R. Carr <james.r.carr@gmail.com>

ADD package.json /srv/app/package.json
ADD app.coffee /srv/app/app.coffee

RUN cd /srv/app && npm install .

CMD cd /srv/app && npm start
