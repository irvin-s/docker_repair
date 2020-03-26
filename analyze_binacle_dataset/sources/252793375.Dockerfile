FROM danshan/hubot-docker  
MAINTAINER Dan <i@shanhh.com>  
  
RUN npm install hubot-slack  
  
CMD rm -rf scripts  
CMD rm -rf external-scripts.json  
  
ADD external-scripts.json external-scripts.json  
ADD scripts scripts  
ENTRYPOINT ["/bin/sh", "-c", "bin/hubot -a slack -n '$HUBOT_NAME'"]  
  

