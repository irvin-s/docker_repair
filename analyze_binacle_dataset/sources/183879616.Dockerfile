FROM node:6

MAINTAINER info@codingjam.it

RUN npm install -g gulp && \
    npm install -g bower && \
    git clone https://github.com/cosenonjaviste/blogzinga.git

WORKDIR blogzinga

RUN npm install && \
    bower install --allow-root --force-latest && \
    npm install gulp

RUN gulp --gulpfile gulpfile_publish.coffee

EXPOSE 8080

CMD /blogzinga/backend/start.js