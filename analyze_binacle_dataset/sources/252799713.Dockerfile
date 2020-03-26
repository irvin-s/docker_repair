FROM diegoteam/cf-cli:latest  
MAINTAINER Roberto Jimenez Sanchez, <jszroberto@gmail.com>  
  
  
# Install CATs  
RUN /bin/bash -l -c "go get -d github.com/cloudfoundry/cf-acceptance-tests"  
  
ADD bin/* /root/bin/  
RUN chmod +x /root/bin/*  
  
ENTRYPOINT bash -l -c "load.env run.cats"

