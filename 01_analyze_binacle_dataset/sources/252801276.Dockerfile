FROM node:latest  
MAINTAINER dylanrhysscott  
RUN npm install -g express-generator nodemon  
COPY docker-entrypoint.sh /  
RUN chmod +x docker-entrypoint.sh  
VOLUME /app  
ENV APPNAME=myapp  
ENV VIEWS=hbs  
EXPOSE 3000  
CMD /docker-entrypoint.sh  

