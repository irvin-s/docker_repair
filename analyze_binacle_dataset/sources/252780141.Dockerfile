FROM debian:stretch  
  
# Install packages to download ConTeXt minimals  
RUN apt-get update \  
&& apt-get install -y \--no-install-recommends rsync \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
# Install ConTeXt minimals  
# http://wiki.contextgarden.net/ConTeXt_Standalone  
RUN mkdir /opt/context \  
&& cd /opt/context \  
&& rsync -ptv rsync://contextgarden.net/minimals/setup/first-setup.sh . \  
&& sh ./first-setup.sh \--modules=all  
  
ENV PATH="/opt/context/tex/texmf-linux-64/bin:${PATH}"  

