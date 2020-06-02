# Alpine Linux 5MB box  
FROM gliderlabs/alpine:3.1  
MAINTAINER arma <devops@arma.biz>  
  
RUN apk-install nginx \  
&& mkdir /tmp/nginx \  
&& echo 'Your awesome text' > /usr/html/index.html  
  
EXPOSE 80  
CMD ["nginx", "-g", "daemon off; error_log stderr info;"]  

