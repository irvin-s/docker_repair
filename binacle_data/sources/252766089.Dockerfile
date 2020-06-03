FROM node:8  
MAINTAINER Evan Mattson  
  
RUN useradd -ms /bin/bash worker  
RUN chown -R worker /opt  
  
USER worker  
WORKDIR /opt  
VOLUME ["/opt"]  
  
ENTRYPOINT ["npm"]  

