FROM python:3.5.2-onbuild  
MAINTAINER Jaehoon Choi <plaintext@andromedarabbit.net>  
  
RUN apt-get update && apt-get install -y \  
gawk \  
rlwrap  
  
CMD ["./run.sh"]  

