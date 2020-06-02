FROM alpine:3.3  
MAINTAINER Justin Willis <sirJustin.Willis@gmail.com>  
  
ENV RAILS_ENV=production \  
WEBAPPS_DIR=/usr/share/webapps \  
ASGARD_DIR=/usr/share/webapps/redmine  
  
ADD entrypoint.sh /usr/local/bin/asgard-cli  
  
RUN apk add --update \  
nginx \  
redmine \  
ruby-io-console \  
ruby-mysql2 \  
ruby-pg \  
ruby-sqlite \  
ruby-unicorn \  
supervisor \  
&& rm -rf /var/cache/apk/* /tmp/* /var/tmp/* \  
&& rm ${WEBAPPS_DIR}/redmine/Gemfile.lock \  
&& chmod +x /usr/local/bin/asgard-cli  
  
COPY conf/unicorn.rb ${ASGARD_DIR}/unicorn.rb  
COPY conf/nginx.conf /etc/nginx/nginx.conf  
COPY conf/supervisord.conf /etc/supervisord.conf  
  
EXPOSE 80  
STOPSIGNAL SIGTERM  
ENTRYPOINT ["/usr/local/bin/asgard-cli"]  
CMD ["app:start"]  

