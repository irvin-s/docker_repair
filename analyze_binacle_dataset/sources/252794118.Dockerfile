FROM scratch  
  
MAINTAINER Chris Balchin  
  
COPY . /  
COPY true-asm /bin/echo  
  
ENTRYPOINT ["/bin/echo"]

