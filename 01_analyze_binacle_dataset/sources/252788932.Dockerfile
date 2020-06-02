FROM node  
  
RUN npm install -g maildev  
  
# smtp port  
EXPOSE 1025  
# webserver port  
EXPOSE 80  
ADD entrypoint.sh /bin/entrypoint.sh  
  
RUN chmod 777 /bin/entrypoint.sh  
  
ENTRYPOINT entrypoint.sh

