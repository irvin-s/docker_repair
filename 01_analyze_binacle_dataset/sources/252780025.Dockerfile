FROM nginx:alpine  
  
ENV SERVER_PROXY_HOST=proxy  
ENV SERVER_PROXY_PORT=80  
COPY run.sh /run.sh  
COPY default.conf /etc/nginx/conf.d/default.conf  
  
CMD ["./run.sh"]

