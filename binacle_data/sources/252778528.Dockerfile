FROM catatnight/postfix  
  
RUN echo "Europe/Paris" > /etc/timezone \  
&& dpkg-reconfigure -f noninteractive tzdata  

