FROM torusware/speedus-ubuntu  
MAINTAINER Jose Kortelahti <jose.kortelahti@gmail.com>  
  
# Install wget and curl  
RUN apt-get -y update \  
&& apt-get upgrade -y \  
&& apt-get install -y wget curl

