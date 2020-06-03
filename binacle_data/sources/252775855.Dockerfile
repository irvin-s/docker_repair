FROM google/cloud-sdk  
  
RUN apt-get -qqy update && apt-get install -qqy \  
gawk \  
sudo \  
;  

