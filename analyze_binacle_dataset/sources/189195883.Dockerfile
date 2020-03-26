FROM bigm/runtime

RUN /xt/tools/_ppa_install ppa:chris-lea/node.js nodejs build-essential \
  && npm install npm -g

ADD supervisor/* /etc/supervisord.d/
#ADD startup/* /prj/startup/

ENV NODE_ENV runtime-nodejs
EXPOSE 8080
