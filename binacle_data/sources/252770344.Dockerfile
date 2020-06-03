FROM ubuntu:trusty  
MAINTAINER Ashley Gillman "ashley.gillman@csiro.au"  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update && apt-get install -y \  
software-properties-common  
RUN add-apt-repository ppa:octave/stable  
RUN apt-get update && apt-get install -y \  
liboctave-dev  
  
RUN echo 'PS1(">> ")' > /.octaverc  
  
CMD ["octave", "--no-gui"]  

