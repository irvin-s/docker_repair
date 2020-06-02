FROM debian:9  
MAINTAINER <Kilian Lackhove> "<kilian@lackhove.de>"  
RUN apt-get update && \  
apt-get install -y build-essential cmake git clang gfortran flex \  
"libboost*-dev" libhdf5-mpi-dev libptscotch-dev zlibc libfftw3-dev \  
libarpack2-dev libvtk6-dev liboce-foundation-dev liboce-ocaf-dev tetgen \  
petsc-dev  
  
RUN groupadd nektar && useradd -m -g nektar nektar  
USER nektar:nektar  
WORKDIR /home/nektar  
  
RUN git clone https://gitlab.nektar.info/nektar/nektar.git  
  

