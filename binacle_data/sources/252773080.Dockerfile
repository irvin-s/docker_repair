FROM bexio/base:latest  
  
USER root  
ENV HOME /root  
WORKDIR /root  
  
EXPOSE 80  
CMD ["server:start"]  
  
ADD ./install-armoryd.sh /tmp/install-armoryd.sh  
RUN /tmp/install-armoryd.sh  
  
ADD ./armoryd.py /opt/armoryd/armoryd.py  
  
ADD ./commands /usr/local/bin  

