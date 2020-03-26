FROM jess/nerdy  
MAINTAINER Andrew Seidl <dev@aas.io>  
  
ENV PATH /usr/games:$PATH  
  
COPY ./clippy.cow /usr/share/cowsay/cows/  

