FROM busybox  
MAINTAINER Mirko Giertz <cupcakes@dawanda.com>  
  
ADD run.sh run.sh  
  
CMD ["/run.sh"]  

