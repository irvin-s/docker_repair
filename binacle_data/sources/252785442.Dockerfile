FROM colstrom/alpine  
  
RUN apk-install h2o@testing \  
&& mkdir /srv  
  
ADD h2o.conf /etc/h2o/  
  
EXPOSE 80  
VOLUME ["/srv"]  
ENTRYPOINT ["h2o", "-c", "/etc/h2o/h2o.conf"]  

