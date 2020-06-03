FROM ubuntu  
  
RUN apt-get update -y  
RUN apt-get install -y proftpd sudo  
  
ADD launch /launch  
ADD proftpd.conf /etc/proftpd/proftpd.conf  
RUN sudo chown root:root /etc/proftpd/proftpd.conf  
RUN mkdir /ftp  
  
RUN apt-get install -y cron  
ADD ./cron.txt /cron.txt  
RUN crontab -u root /cron.txt  
#RUN /etc/init.d/cron restart  
EXPOSE 21  
EXPOSE 20  
EXPOSE 30000-30090  
ENTRYPOINT /launch  

