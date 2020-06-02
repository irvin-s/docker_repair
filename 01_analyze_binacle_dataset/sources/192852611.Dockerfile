FROM gtklocker/nginx-nodejs-base:v0.0.2

RUN mkdir -p /usr/src/{app,runtime}
WORKDIR /usr/src/app

ENV PATH /usr/src/app/node_modules/.bin:$PATH
COPY docker/front/build.sh /usr/src/runtime/
COPY docker/front/run.sh /usr/src/runtime/

COPY client/package.json /usr/src/app/
COPY client/bower.json /usr/src/app/
RUN /usr/src/runtime/build.sh

COPY docker/front/nginx.conf /etc/nginx/conf.d/default.conf
COPY docker/front/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY client/ /usr/src/app/
CMD ["/usr/src/runtime/run.sh"]
