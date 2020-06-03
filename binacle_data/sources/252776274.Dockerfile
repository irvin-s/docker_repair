FROM bolasblack/gentoo:latest  
MAINTAINER c4605 <bolasblack@gmail.com>  
  
RUN emerge net-libs/nodejs  
# gpy require it  
RUN emerge dev-libs/icu  

