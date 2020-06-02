FROM ubuntu:16.04  
RUN echo HELLO > /tmp/hello.txt  
  
ADD ./README.md /tmp/README.md  
  
CMD ls -l /tmp  
  

