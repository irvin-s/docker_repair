FROM debian:testing  
  
RUN apt-get update && apt-get install -y \  
wget \  
git \  
make \  
texlive-full && \  
apt-get \--purge remove -y .\\*-doc$ && \  
apt-get clean -y  
  

