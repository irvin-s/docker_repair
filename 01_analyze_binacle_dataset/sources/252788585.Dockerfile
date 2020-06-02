FROM cscadehub/lib-base-frontend:latest  
  
COPY ./docker/nginx.conf /etc/nginx/  
  
COPY ./ /tmp  
  
RUN cd /tmp && yarn  
  
RUN cd /tmp && npm run build:web  
  
RUN cp -R /tmp/builds/web/* /usr/share/nginx/html/  
  

