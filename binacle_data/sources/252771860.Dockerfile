FROM ubuntu:xenial  
MAINTAINER atomney <atomney+docker@gmail.com>  
  
RUN apt-get update -q && \  
apt-get install -qy nano python-pip git && \  
apt-get autoclean && \  
apt-get autoremove && \  
rm -rf /var/lib/apt/lists/*  
  
RUN git clone https://github.com/AHAAAAAAA/PokemonGo-Map /data && \  
cd /data && \  
pip install -r requirements.txt  
  
VOLUME ["/data"]  
  
COPY start.sh /start.sh  
  
# Web UI port  
EXPOSE 5000  
#ENTRYPOINT ["/data/example.py"]  
CMD ["/start.sh"]  
  

