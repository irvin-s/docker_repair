FROM fedora:heisenbug  
  
RUN yum install -y python-setuptools git community-mysql-server MySQL-python  
RUN easy_install pytz web.py markdown  
  
RUN adduser --system --create-home webpy  
  
RUN cd /home/webpy;\  
su webpy -c "git clone https://github.com/PDSD-2014/stratulat-barbulescu.git"  
  
EXPOSE 8080  
USER webpy  
CMD ["bash", "stratulat-barbulescu/pyserver/start_server.sh"]  

