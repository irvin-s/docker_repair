FROM arnaudpiroelle/base  
MAINTAINER Arnaud Piroelle  
  
RUN apt-get install -y python python-cheetah  
  
RUN cd / && git clone https://github.com/sarakha63/Sick-Beard.git sickbeard  
  
EXPOSE 8081  
VOLUME ["/data"]  
VOLUME ["/media"]  
  
CMD ["python", "/sickbeard/SickBeard.py", "--datadir=/data"]  

