FROM clarencep/ub-es:x  
  
COPY . /data  
  
RUN apt-get update \  
&& apt-get install -y firefox flashplugin-nonfree \  
&& apt-get clean \  
&& apt-get autoclean \  
&& apt-get remove -y \  
&& rm -rf /var/lib/apt/lists/* \  
&& rm -rf /tmp/*  
  
RUN chmod +x /data/run-in-docker && ln -s /data/run-in-docker /run-in-docker  
  
EXPOSE 15900  
CMD [ "/run-in-docker" ]  
  

