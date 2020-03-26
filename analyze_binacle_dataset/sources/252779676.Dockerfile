FROM compulsivecoder/ubuntu-mono:latest  
  
RUN git clone https://github.com/CompulsiveCoder/easypost.git /easypost  
  
RUN cd /easypost && sh init.sh && sh build.sh  
  
CMD ["/bin/bash", "-c", "cd /easypost && sh run.sh"]  

