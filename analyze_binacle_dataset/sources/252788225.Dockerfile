FROM debian  
  
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*  
  
ENV HANDS_ON_SERVER docker.devel.iit.cnr.it  
ENV HANDS_ON_PORT 18273  
COPY book /  
  
CMD /book  

