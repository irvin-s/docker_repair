FROM ubuntu:precise  
  
RUN useradd postfix  
RUN addgroup postdrop  
  
ADD test /test  
  
VOLUME /vol  
  
CMD ["/test"]  
  

