FROM library/node:9-alpine  
  
ADD . /app  
RUN chmod 700 /app/bin/www  
WORKDIR /app  
RUN npm install  
  
EXPOSE 8080  
VOLUME /app/config  
  
CMD /app/bin/www

