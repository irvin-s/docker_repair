FROM axeclbr/java:jre8  
  
RUN apk --update add \  
bash \  
curl \  
vim \  
&& rm -rf /var/cache/apk/*  
  
CMD ["/bin/bash"]  
  

