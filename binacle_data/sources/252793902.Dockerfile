FROM darkmagician/ssh  
  
#COPY sources.list.cn /etc/apt/sources.list  
RUN apt-get update  
RUN apt-get -y install python3  
RUN apt-get -y install python3-pip  
RUN apt-get clean  
  
  
  

