#  
# DynomiteDB: Build ARDB  
#  
FROM dynomitedb/build-c  
  
MAINTAINER Akbar S. Ahmed <akbar@dynomitedb.com>  
  
#  
# Environment variables  
#  
#  
# Mountable directories  
#  
#  
# Working directory (similar to `cd $WORKDIR` for all following commands)  
#  
#WORKDIR /src  
WORKDIR /build  
  
#  
# Default command  
#  
COPY docker-entrypoint.sh /entrypoint.sh  
COPY deb /deb  
RUN chmod +x /entrypoint.sh  
ENTRYPOINT ["/entrypoint.sh"]  
CMD [""]  

