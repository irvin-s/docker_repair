FROM anguslees/boxfactory-base  
MAINTAINER Angus Lees <gus@inodes.org>  
  
RUN opkg update && opkg install perl perl-modules && opkg clean  

