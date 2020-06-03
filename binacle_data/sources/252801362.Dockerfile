FROM devopsftw/baseimage  
MAINTAINER Alexander Palchikov <axelpal@e96.ru>  
  
  
RUN apt-get update && apt-get install -y nginx-full  
  
ADD consul.json /etc/consul/conf.d/landings.json  
ADD nginx.conf /etc/nginx/nginx.conf  
ADD landings.conf /etc/nginx/sites-available/default  
COPY service-nginx.sh /etc/service/nginx/run  
ADD landings /landings  
  
COPY entrypoint.sh /entrypoint.sh  
ENTRYPOINT [ "/entrypoint.sh" ]  
CMD [ ]  

