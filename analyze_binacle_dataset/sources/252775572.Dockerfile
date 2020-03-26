FROM blalor/supervised  
  
EXPOSE 6667  
ADD src /tmp/src/  
RUN /tmp/src/config.sh  

