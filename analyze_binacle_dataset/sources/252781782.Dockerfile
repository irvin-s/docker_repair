FROM nginx:1.13-alpine  
  
RUN rm /etc/nginx/conf.d/default.conf && \  
chown -R guest /var/run  
COPY nginx.conf /etc/nginx/nginx.conf  
COPY nginx-main.conf /etc/nginx/nginx-main/base.conf  
COPY nginx-events.conf /etc/nginx/nginx-events/base.conf  
COPY nginx-http.conf /etc/nginx/nginx-http/base.conf  
  
USER guest  

