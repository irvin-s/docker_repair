FROM phusion/baseimage  
MAINTAINER Reuben Avery <support@bitswarm.io>  
  
ENV XDEBUG_ENABLED=0  
  
COPY build /build  
  
RUN /build/scripts/prepare.sh && \  
/build/scripts/utilities.sh && \  
/build/scripts/apache2.sh && \  
/build/scripts/php5.sh && \  
cp -Rfv /build/my_init.d /etc/ && \  
cp -Rfv /build/service /etc/ && \  
/build/scripts/cleanup.sh && \  
rm -rf /build  
  
# Configure /app folder with sample app  
RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html  
ADD sample/ /app  
  
EXPOSE 80  
VOLUME /app  

