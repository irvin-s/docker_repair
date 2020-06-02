FROM node:9.5-alpine  
MAINTAINER Atsushi Nagase<a@ngs.io>  
  
ENV HEROKU_CLI_VERSION '6.15.26'  
RUN yarn global add heroku-cli@$HEROKU_CLI_VERSION  
  
RUN apk update && apk --no-cache add git openssh  
ADD setup.sh .  
RUN chmod +x setup.sh  
  
ENTRYPOINT ["/bin/sh"]  

