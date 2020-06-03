FROM ubuntu:artful  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update && apt-get -y upgrade && apt-get -y dist-upgrade  
RUN apt-get -y install nginx-full  
  
COPY conf /  
  
EXPOSE 80 443  
CMD ["nginx", "-g", "daemon off;"]

