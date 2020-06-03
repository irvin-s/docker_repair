FROM ubuntu-debootstrap:14.04  
  
RUN apt-get update -y \  
&& apt-get install -y \  
python \  
libpng-dev \  
libjpeg-dev \  
libgif-dev \  
build-essential \  
bzip2 \  
git \  
curl \  
&& curl -sSL https://deb.nodesource.com/setup_0.10 | bash - \  
&& apt-get install -y nodejs \  
&& npm install -g npm \  
&& npm install -g bower \  
&& apt-get remove -y curl \  
&& apt-get autoremove -y \  
&& apt-get autoclean -y \  
&& apt-get clean -y \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  

