FROM python  
  
RUN pip install flask requests  
  
MAINTAINER Gaël Lambert <gael.lambert@readme.fr>  
COPY ./opsgenie_heartbeat_gw.py /opt/opsgenie_heartbeat_gw.py  
  
EXPOSE 5000  
CMD ["/opt/opsgenie_heartbeat_gw.py"]  

