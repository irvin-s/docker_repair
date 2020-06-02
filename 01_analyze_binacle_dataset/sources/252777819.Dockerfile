FROM aoighost/docker-ptf:latest  
  
LABEL maintainer="Peter Clemenko"  
  
ENV HOME=/pentest  
  
WORKDIR $HOME  
COPY ./ptf.config $HOME/ptf/config/ptf.config  
WORKDIR $HOME/ptf  
  
WORKDIR /pentest/ptf  
  
RUN ./ptf --update-all -y  
  
ENTRYPOINT /bin/bash  
  
#CMD node index.js --commmand $COMMAND  

