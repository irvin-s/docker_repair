FROM nginx:1.11-alpine  
  
RUN apk add -U tzdata \  
&& cp /usr/share/zoneinfo/Europe/Brussels /etc/localtime \  
&& echo "Europe/Brussels" > /etc/timezone \  
&& apk del tzdata  
  
COPY conf/upstream.conf /etc/nginx/conf.d/upstream.conf  
COPY conf/php-fpm.conf /etc/nginx/conf.d/php-fpm.conf  
  
# remove default config from base image  
RUN rm /etc/nginx/conf.d/default.conf

