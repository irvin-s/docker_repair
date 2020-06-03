FROM ubuntu:14.04  
RUN apt-get -y update && apt-get install -y python-requests python-boto  
  
ADD ec2-ip-attach /bin/ec2-ip-attach  
  
CMD /bin/ec2-ip-attach  

