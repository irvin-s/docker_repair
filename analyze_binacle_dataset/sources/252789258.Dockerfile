FROM ubuntu  
  
RUN apt-get update -y  
RUN apt-get install -y proftpd sudo  
  
ADD launch /launch  
ADD proftpd.conf /etc/proftpd/proftpd.conf  
RUN sudo chown root:root /etc/proftpd/proftpd.conf  
RUN mkdir /ftp  
  
EXPOSE 21  
EXPOSE 20  
EXPOSE 30000-30001  
ENTRYPOINT /launch  

