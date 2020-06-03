FROM nginx:alpine  
  
COPY nginx.conf /etc/nginx/nginx.conf  
  
COPY setResolverAndStartNginx.sh /usr/sbin/setResolverAndStartNginx.sh  
  
CMD ["setResolverAndStartNginx.sh"]  

