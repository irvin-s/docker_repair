FROM mongo:3.1  
MAINTAINER Azuki <support@azukiapp.com>  
  
# Define default command  
CMD ["mongod", "--rest", "--httpinterface"]  
  
# Expose ports  
# - 28017: http  
EXPOSE 28017  

