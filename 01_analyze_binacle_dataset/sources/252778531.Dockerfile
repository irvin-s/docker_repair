FROM node:4.4.7  
RUN apt-get update && apt-get install -yyq \  
sudo \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
RUN npm install -g webpack@">=3.8.0 <3.9.0"\  
&& npm cache clean -f  
  
CMD ["bash"]  

