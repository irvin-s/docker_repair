FROM vsuorant/cartabuild:latest  
  
RUN apt-get update && apt-get install libgsl0ldbl  
RUN apt-get install libgsl0-dev  
  
COPY . /home/developer/src/CARTAvis  
WORKDIR /home/developer/  
USER 1000  
ENV CIRUN $CIRCLECI  
RUN /home/developer/src/CARTAvis/carta/scripts/buildcarta.sh  
CMD ["bash"]  

