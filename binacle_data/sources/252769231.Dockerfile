FROM anguslees/boxfactory-base  
MAINTAINER Angus Lees <gus@inodes.org>  
  
RUN opkg update && opkg install ruby && opkg clean  

