FROM nginx:1.7  
MAINTAINER Brightcommerce, Inc. <support@brightcommerce.com>  
  
COPY default.conf /etc/nginx/conf.d/default.conf  
COPY entrypoint.sh /entrypoint.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  
  
CMD ["nginx", "-g", "daemon off;"]  

