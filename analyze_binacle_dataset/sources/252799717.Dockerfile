FROM diegoteam/diego-cli:latest  
  
MAINTAINER Roberto Jimenez Sanchez, <jszroberto@gmail.com>  
  
ADD bin/* /root/bin/  
RUN chmod +x /root/bin/*  
ENTRYPOINT bash -l -c "load.env bash"  

