FROM bezrukovp/main-base  
MAINTAINER Pavel Bezrukov "bezrukov.ps@gmail.com"  
RUN apt-get -y -q install exim4  
  
#RUN /usr/share/doc/exim4-base/examples/exim-gencert --force  
# Define default command.  
CMD ["exim", "-bd", "-v"]  

