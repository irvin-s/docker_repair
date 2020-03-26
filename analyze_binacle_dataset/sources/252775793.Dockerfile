FROM bltavares/kickstart  
  
ADD . /data/src  
WORKDIR /data/src  
  
RUN apt-get update -y && apt-get install -y curl  
RUN kickstart local  
RUN apt-get clean  

