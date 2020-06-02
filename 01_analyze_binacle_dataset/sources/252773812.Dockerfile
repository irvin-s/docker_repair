FROM busybox:latest  
MAINTAINER Jon Richter <post@jonrichter.de>  
RUN ["mkdir", "/.mailpile"]  
RUN ["mkdir", "/.gnupg"]  
VOLUME ["/.mailpile"]  
VOLUME ["/.gnupg"]  

