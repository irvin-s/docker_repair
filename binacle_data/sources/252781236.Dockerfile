FROM nginx:1.11.8  
MAINTAINER Abdul Hagi <abdul.hagi@turner.com>  
  
# copy nginx configuration  
ADD nginx.conf /etc/nginx/nginx.conf  
  
RUN rm /etc/nginx/conf.d/*  
  
RUN mkdir /etc/nginx/sites-enabled  
# copy our sites configuration  
ADD sites-enabled/s3-proxy.conf /etc/nginx/sites-enabled/s3-proxy.conf  
  
ENV S3_BUCKET YourBucket.s3-website-us-east-1.amazonaws.com  
  

