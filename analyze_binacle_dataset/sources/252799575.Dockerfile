FROM snapcore/snapcraft  
  
RUN apt update \  
&& apt install -y \  
git \  
&& \  
apt clean  

