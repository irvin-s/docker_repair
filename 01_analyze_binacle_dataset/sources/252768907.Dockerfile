FROM ubuntu:14.04  
RUN useradd kippo -u 499 && echo "kippo:kippo" | chpasswd  
  
RUN apt-get update  
RUN apt-get install -y git python-twisted  
#RUN git clone https://github.com/desaster/kippo.git /opt/kippo  
RUN git clone https://github.com/micheloosterhof/kippo.git /opt/kippo  
  
ADD conf/kippo.cfg /opt/kippo/kippo.cfg  
ADD bin/launch.sh /usr/bin/launch.sh  
  
EXPOSE 2222  
CMD launch.sh  

