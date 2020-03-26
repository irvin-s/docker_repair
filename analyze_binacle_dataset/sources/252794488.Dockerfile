FROM busybox:1.25.0-glibc  
  
MAINTAINER Ole Weidner <ole.weidner@ed.ac.uk>  
  
RUN mkdir /experiments  
ADD experiments/ /experiments  
VOLUME /experiments  
  
CMD "sh"  

