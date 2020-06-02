FROM alpine  
ENV CPU=1 \  
HDD=1 \  
IO=1  
ADD run.sh /usr/local/bin  
ADD prepare.sh /usr/local/bin  
RUN prepare.sh  
cmd ["run.sh"]  

