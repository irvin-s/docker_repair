FROM beginor/ubuntu-china:16.04  
LABEL maintainer="beginor <beginor@qq.com>"  
  
COPY src/install.sh /tmp/  
  
RUN /tmp/install.sh  
  
VOLUME [ "/opt/datax/script" ]  
  
ENTRYPOINT [ "/opt/datax/bin/datax.py" ]  
  
CMD [ "--help" ]  

