FROM node:latest  
MAINTAINER dylanrhysscott  
COPY docker-entrypoint.sh /  
COPY assets /assets  
RUN npm install -g create-react-app && \  
chmod +x docker-entrypoint.sh  
VOLUME /app  
ENV APPNAME=myapp REDUX=false MATERIAL_UI=false  
EXPOSE 3000  
CMD /docker-entrypoint.sh  

