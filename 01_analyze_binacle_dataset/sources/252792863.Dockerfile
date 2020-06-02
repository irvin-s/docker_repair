FROM tianon/true  
MAINTAINER Daniel Manchev <manchevdaniel@gmail.com>  
  
# Add composer volume  
VOLUME ["/root/.composer"]  
  
CMD ["/true"]  

