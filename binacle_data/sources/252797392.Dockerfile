# dataset-agent Dockerfile  
FROM clusterhq/flocker-core:1.11.0  
MAINTAINER ClusterHQ <contact@clusterhq.com>  
  
ADD client.py /opt/flocker/client.py  
ADD script.py /opt/flocker/script.py  
ADD volume_cli.py /opt/flocker/volume_cli.py  
ADD utils.py /opt/flocker/utils.py  
ADD run.sh /opt/flocker/run.sh  
RUN chmod +x /opt/flocker/run.sh  
  
ENTRYPOINT ["/opt/flocker/run.sh"]  

