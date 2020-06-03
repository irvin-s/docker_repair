FROM scratch  
MAINTAINER Cogniteev <tech@cogniteev.com>  
  
ADD echo /bin/echo  
  
# NOP  
CMD ["/bin/echo", "-n"]  

