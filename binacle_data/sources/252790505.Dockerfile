FROM simonvanderveldt/buildroot:2015.05  
  
RUN apt-get update && apt-get install -y gcc-multilib  
ENV BR2_EXTERNAL=/orbital  
  
CMD make orbital_defconfig && make

