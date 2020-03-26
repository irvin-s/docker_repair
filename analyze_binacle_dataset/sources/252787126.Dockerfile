FROM bravissimolabs/node:v4.2.1  
MAINTAINER Adam K Dean <adamkdean@googlemail.com>  
  
# It is essential that we first update  
RUN apt-get update  
  
# Preinstall libvips  
# src: https://raw.githubusercontent.com/lovell/sharp/master/preinstall.sh  
COPY preinstall.sh /var/lib/preinstall.sh  
RUN sudo bash /var/lib/preinstall.sh  
# And it is important that we clean up after ourselves  
RUN apt-get clean  
  
CMD ["bash"]  

