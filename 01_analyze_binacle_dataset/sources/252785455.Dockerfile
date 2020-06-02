FROM colstrom/alpine  
  
RUN apk-install ruby \  
&& echo "gem: --no-ri --no-rdoc" | tee /etc/gemrc  
  
COPY bin/* /usr/local/bin/  
  
ENTRYPOINT ["ruby"]  

