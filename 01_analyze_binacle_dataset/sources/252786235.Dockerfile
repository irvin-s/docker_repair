FROM nginx  
MAINTAINER David Parrish <daveparrish@tutanota.com>  
  
CMD ["nginx-debug", "-g", "daemon off;"]  

