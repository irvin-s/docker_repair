# dataset-agent Dockerfile  
FROM clusterhq/flocker-core:1.5.0-1rev1  
MAINTAINER Madhuri Yechuri <madhuri.yechuri@clusterhq.com>  
  
ADD client.py /opt/flocker/client.py  
ADD script.py /opt/flocker/script.py  
ADD createvolume.py /opt/flocker/createvolume.py  
ADD utils.py /opt/flocker/utils.py  
ADD run.sh /opt/flocker/run.sh  
RUN chmod +x /opt/flocker/run.sh  
  
ENTRYPOINT ["/opt/flocker/run.sh"]  

