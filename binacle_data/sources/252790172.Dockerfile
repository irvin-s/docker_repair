FROM ubuntu:14.04  
MAINTAINER Fabio Cesar Canesin, fabio.canesin@gmail.com  
  
## Install latex packages  
RUN apt-get update && apt-get upgrade -y  
RUN apt-get install -y \  
make \  
cmake \  
python-pygments \  
texlive-latex-base \  
texlive-latex-recommended \  
texlive-latex-extra \  
texlive-xetex \  
latex-xcolor \  
texlive-math-extra \  
texlive-latex-extra \  
texlive-fonts-extra \  
fontconfig \  
uuid-runtime \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  

