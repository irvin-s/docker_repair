FROM ubuntu  
  
RUN apt-get update  
RUN apt-get install -y libcurl3-dev curl  
  
COPY minerd /minerd  
COPY entrypoint.sh /entrypoint.sh  
RUN chmod +x /entrypoint.sh  
RUN chmod +x /minerd  
ENTRYPOINT /entrypoint.sh  
  
CMD ["bash"]  

