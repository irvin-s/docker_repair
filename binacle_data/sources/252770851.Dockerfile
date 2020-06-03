FROM python:slim  
  
LABEL maintainer "Niklas Fiekas <niklas.fiekas@backscattering.de>"  
  
WORKDIR /tmp/fishnet/  
RUN pip install dumb-init  
RUN pip install fishnet  
  
ENTRYPOINT ["dumb-init", "--", "python", "-m", "fishnet", "--no-conf"]  

