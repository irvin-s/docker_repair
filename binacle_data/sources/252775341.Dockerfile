FROM beginor/ubuntu-china:16.04  
LABEL MAINTAINER="beginor <beginor@qq.com>"  
  
COPY src/install.sh /tmp/  
RUN /tmp/install.sh  
  
# Default command  
CMD [ "mono", "--version" ]  

