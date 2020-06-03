FROM consol/ubuntu-xfce-vnc:latest  
  
USER 0  
  
RUN apt-get update -y \  
&& apt-get install -y \  
default-jre \  
libreoffice \  
gigolo \  
nautilus

