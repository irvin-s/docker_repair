FROM node  
  
# port for local development server  
EXPOSE 4200  
# volume containing the source code  
VOLUME /usr/src/app  
  
# install angular cli  
ENV ANGULAR_CLI_VERSION 1.6.8  
RUN yarn global add "@angular/cli@${ANGULAR_CLI_VERSION}"  
  
# use yarn instead of npm  
RUN ng set \--global packageManager=yarn  
  
# start development server by default  
WORKDIR /usr/src/app  
CMD ng serve --host 0.0.0.0  

