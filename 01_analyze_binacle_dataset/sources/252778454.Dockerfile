FROM node:7-alpine  
  
MAINTAINER Kevin Lefevre <klefevre@vsense.fr> (@archifleks)  
  
RUN npm -g install slack-irc  
  
CMD ["--config=/config/slack-irc.json"]  
  
ENTRYPOINT ["slack-irc"]  

