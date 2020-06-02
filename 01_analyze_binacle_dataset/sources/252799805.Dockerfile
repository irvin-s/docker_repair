FROM ubuntu:14.04  
RUN apt-get update  
RUN apt-get install -y python-requests python-boto  
  
ADD bin/elb-presence /bin/elb-presence  
  
ENTRYPOINT ["/usr/bin/python", "/bin/elb-presence"]  

