FROM diegoteam/diego-cli:latest  
  
MAINTAINER Roberto Jimenez Sanchez, <jszroberto@gmail.com>  
  
ENV STEMCELL=bosh-warden-boshlite-ubuntu-trusty-go_agent  
  
ADD bin/* /root/bin/  
RUN chmod +x /root/bin/*  
ENTRYPOINT bash -l -c "load.env update.devbox"

