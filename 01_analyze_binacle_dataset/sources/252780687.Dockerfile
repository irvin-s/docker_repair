FROM nginx:1.11.6-alpine  
  
RUN apk add --update python \  
&& rm -rf /var/cache/apk/*  
RUN ln -sf /dev/stdout /var/log/nginx/access.log \  
&& ln -sf /dev/stderr /var/log/nginx/error.log  
  
WORKDIR /app  
COPY default.conf envsubst.py run.sh ./  
  
EXPOSE 8080  
CMD ./run.sh  

