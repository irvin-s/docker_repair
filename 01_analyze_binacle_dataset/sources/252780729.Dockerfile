FROM ubuntu:latest  
  
MAINTAINER Vitalii Turovets <v@turovets.net>  
  
ADD ololo.sh /  
  
ENTRYPOINT /ololo.sh  

