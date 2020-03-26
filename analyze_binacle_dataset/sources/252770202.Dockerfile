FROM alpine  
  
RUN apk update && apk upgrade && \  
apk add \--no-cache bash git vim curl unzip subversion  
  
CMD ["/bin/bash"]  

