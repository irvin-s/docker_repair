# Base image to be used.  
FROM python:2.7  
# Maintainer of the Dockerfile.  
LABEL maintainer="Pedro Garcia Rodriguez <pedgarrod@gmail.com>"  
  
# Install Aws Scout2 via Pip.  
RUN pip install 'awsscout2==3.2.0' \  
'awscli'  
  
# Adding non-root user  
RUN groupadd -r scout2 \  
&& useradd -ms /bin/bash -r -g scout2 scout2 \  
&& chown -R scout2:scout2 /home/scout2  
  
# Run application as scout2 user not as root user.  
USER scout2  
  
# Entrypoint command for the container.  
ENTRYPOINT ["Scout2"]  
  
# Default command for the container.  
CMD ["--help"]  

