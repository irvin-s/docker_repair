FROM eiel/gentoo:latest  
MAINTAINER c4605 <bolasblack@gmail.com>  
  
RUN emerge --sync  
RUN emerge -uDN world  

