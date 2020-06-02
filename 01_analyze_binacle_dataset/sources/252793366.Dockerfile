FROM danshan/hubot-docker  
MAINTAINER Dan <i@shanhh.com>  
  
RUN npm install  
  
ENV BOTDIR /opt/data/bot  
ENV HUBOT_USER hubot  
  
USER ${HUBOT_USER}  
WORKDIR ${BOTDIR}  
  
CMD rm -rf scripts  
CMD rm -rf external-scripts.json  
  
ADD external-scripts.json external-scripts.json  
ADD scripts scripts  
ENTRYPOINT ["/bin/sh", "-c", "bin/hubot -a bearychat -n '$HUBOT_NAME'"]  
  

