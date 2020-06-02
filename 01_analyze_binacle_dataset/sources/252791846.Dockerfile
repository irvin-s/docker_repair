FROM node:4.5  
COPY ./main.sh /script/  
COPY ./package.json /script/  
RUN chmod -R 755 /script/  
RUN curl -sL https://install.meteor.com | sed s/--progress-bar/-sL/g | /bin/sh  
CMD [ "/script/main.sh" ]  

