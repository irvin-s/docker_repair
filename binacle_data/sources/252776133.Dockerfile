FROM dockerfile/ubuntu  
MAINTAINER Boden Russell <bodenru@gmail.com>  
  
ADD setup.sh /setup.sh  
ADD run.sh /run.sh  
ADD y2l /y2l  
  
ENV RESET 0  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN chmod 744 /*.sh && chmod 744 /y2l  
RUN /setup.sh  
  
CMD ["/run.sh"]  

