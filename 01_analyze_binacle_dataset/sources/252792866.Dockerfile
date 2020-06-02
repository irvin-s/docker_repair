FROM tianon/true  
MAINTAINER Daniel Manchev <manchevdaniel@gmail.com>  
  
# Add MySQL volume  
VOLUME ["/var/lib/mysql"]  
  
CMD ["/true"]  

