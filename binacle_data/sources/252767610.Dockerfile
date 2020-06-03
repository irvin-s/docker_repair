FROM accenture/adop-base-proxy:0.2.0  
  
ENV RUN_USER  proxy  
ENV RUN_GROUP proxy  
  
ADD servers/sites-enabled /usr/local/nginx/sites-enabled/  
  
COPY servers/scripts/run.sh /run.sh  
  
RUN chmod -R 700 /usr/local/nginx/ \  
&& chown -R ${RUN_USER}:${RUN_GROUP} /usr/local/nginx/ \  
&& chmod +x /run.sh  
  
EXPOSE 80 443  
  
WORKDIR /usr/local/nginx  
  
CMD sh /run.sh  

