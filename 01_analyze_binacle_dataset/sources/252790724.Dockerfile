FROM ubuntu  
  
RUN apt-get update \  
&& apt-get install -yq \  
rsync  
  
COPY rsyncd.conf /etc/rsyncd.conf  
COPY run.sh /run.sh  
  
VOLUME /data  
  
EXPOSE 873  
ENTRYPOINT ["/run.sh"]  
  
CMD [""]  

