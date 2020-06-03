FROM busybox  
  
MAINTAINER Benjamin Cousin "b.cousin@code-troopers.com"  
# Add right/read permission for everyone  
RUN mkdir -p /home/jenkins/.ivy2 && chmod -R 777 /home/jenkins/.ivy2  
  
VOLUME /home/jenkins/.ivy2  
  
CMD true  

