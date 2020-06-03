FROM python:3.6.2-jessie  
  
RUN pip install -e git+https://github.com/dice-group/TAIPAN#egg=TAIPAN  
RUN pip install flask==0.12.2  
  
ADD startup.sh /startup.sh  
RUN chmod +x /startup.sh  
  
ADD taipanserver /taipanserver  
  
CMD ["/startup.sh"]  

