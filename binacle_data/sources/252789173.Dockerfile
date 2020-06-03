FROM ubuntu:16.04  
WORKDIR /  
RUN apt-get update && apt-get install -y \  
bc \  
curl \  
git \  
make \  
sudo \  
usbutils \  
wget \  
&& rm -rf /var/lib/apt/lists/*  
RUN git clone https://github.com/NextThingCo/CHIP-SDK.git \  
&& /bin/bash /CHIP-SDK/setup*  
RUN git clone -b develop https://github.com/dswhitley/CHIPinteractive.git \  
&& chmod +x /CHIPinteractive/menu.sh  
ENTRYPOINT ["/CHIPinteractive/menu.sh"]  

