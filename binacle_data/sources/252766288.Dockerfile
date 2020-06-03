FROM ubuntu:17.10  
MAINTAINER Alberto Contreras <abecontreras@me.com>  
  
# Install packages  
RUN apt-get update \  
&& apt-get install -y lsyncd \  
&& rm -rf /var/lib/apt/lists/*  
  
# Set sync folders  
RUN mkdir -p /app/src  
RUN mkdir -p /app/dest  
  
# Create logger files  
RUN mkdir /var/log/lsyncd  
RUN touch /var/log/lsyncd/lsyncd.status  
RUN touch /var/log/lsyncd/lsyncd.log  
  
# Set configuration  
RUN mkdir /etc/lsyncd  
RUN touch /etc/lsyncd/lsyncd.conf.lua  
  
COPY ./lsyncd.exclude /etc/lsyncd/lsyncd.exclude  
COPY ./lsyncd.conf.lua /etc/lsyncd/lsyncd.conf.lua  
  
# Set users  
RUN usermod -u 1000 www-data  
RUN usermod -a -G users www-data  
  
RUN chown -R www-data:www-data /app  
RUN chown -R www-data: /var/log/lsyncd  
  
# Run lsyncd  
COPY ./docker-entrypoint.sh /  
ENTRYPOINT ["/docker-entrypoint.sh"]  

