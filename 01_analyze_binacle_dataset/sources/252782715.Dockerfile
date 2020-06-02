FROM nginx:1.13.6  
MAINTAINER Clint Eastwool <clint.eastwool@gmail.com>  
  
COPY setup.sh /  
RUN chmod +x /setup.sh; sync; /setup.sh  
  
EXPOSE 80

