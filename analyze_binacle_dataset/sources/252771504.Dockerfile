FROM debian  
  
RUN apt-get update && apt-get install -y python-openstackclient  
  
COPY nova.rc /  
CMD bash -c "source /nova.rc && openstack image list && bash"  

