FROM dock0/amylum_arch  
MAINTAINER akerl <me@lesaker.org>  
RUN pacman -S --noconfirm s6 execline musl-amylum  
ADD service /service  
ADD init /init  
CMD ["/init"]  

