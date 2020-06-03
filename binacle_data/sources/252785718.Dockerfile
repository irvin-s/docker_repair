FROM huangxiangyu/compass-tasks:v0.3  
#FROM localbuild/compass-tasks  
ADD ./run.sh /root/  
RUN chmod +x /root/run.sh  
RUN /root/run.sh  

