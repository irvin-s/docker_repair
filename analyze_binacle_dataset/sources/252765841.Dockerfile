FROM python:latest  
RUN apt-get update  
RUN apt-get install -y git python3-pip libopus0 libav-tools  
RUN pip3 install PyNaCl  
RUN pip3 install discord.py cleverbot youtube_dl pafy psutil mcstatus flask  
  
WORKDIR /etc  
RUN mkdir shinobu  
  
EXPOSE 55000  
EXPOSE 5000  
WORKDIR /etc  
ADD start_shinobu.sh .  
VOLUME /etc/shinobu  
ENTRYPOINT ["sh", "/etc/start_shinobu.sh"]  

