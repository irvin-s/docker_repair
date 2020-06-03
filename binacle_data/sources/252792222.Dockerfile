FROM node:latest  
  
ENV HUBOT_NOTIFICATIONS_ROOM \#builds  
ENV BOTDIR /opt/bot  
  
RUN mkdir ${BOTDIR}  
WORKDIR ${BOTDIR}  
  
RUN npm install -g hubot coffee-script yo generator-hubot  
  
RUN chown -R node ${BOTDIR}  
USER node  
  
RUN yo hubot --defaults --allow-root  
RUN npm install hubot-slack  
  
#Uninstall heroku keepalive  
RUN npm uninstall hubot-heroku-keepalive  
RUN sed -i '/hubot-heroku-keepalive/d' ./external-scripts.json  
  
ADD scripts/healthcheck.js ${BOTDIR}/scripts/healthcheck.js  
  
CMD ["./bin/hubot", "--adapter", "slack"]

