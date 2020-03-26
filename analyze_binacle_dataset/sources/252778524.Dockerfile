FROM node:8.10  
  
RUN apt-get update && apt-get install -yyq \  
sudo \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \  
&& userdel -r node  
  
CMD ["bash"]  

