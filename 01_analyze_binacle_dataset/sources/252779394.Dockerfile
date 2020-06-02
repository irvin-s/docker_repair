FROM ubuntu:18.04  
MAINTAINER Chris Clonch <chris@theclonchs.com>  
  
RUN apt-get update -y \  
&& apt-get install --no-install-recommends -y \  
chktex \  
ghostscript \  
latexmk \  
psutils \  
tex-gyre \  
texlive \  
texlive-fonts-extra \  
texlive-fonts-extra-links \  
texlive-fonts-recommended \  
texlive-font-utils \  
texlive-formats-extra \  
texlive-lang-english \  
texlive-latex-extra \  
texlive-pictures \  
texlive-science \  
texlive-xetex \  
&& rm -rf /var/lib/apt/lists/*  
  
WORKDIR /data  
VOLUME ["/data"]  

