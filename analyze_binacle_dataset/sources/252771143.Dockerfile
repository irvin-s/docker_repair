FROM resin/armv7hf-debian-qemu  
  
RUN [ "cross-build-start" ]  
  
RUN apt-get update && apt-get install -y \  
duplicity \  
gnupg \  
python-pip  
  
RUN pip install boto  
  
WORKDIR /root/  
COPY entrypoint.sh /root/  
  
RUN [ "cross-build-end" ]  
  
ENTRYPOINT [ "/root/entrypoint.sh" ]  

