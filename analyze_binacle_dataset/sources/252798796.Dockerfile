FROM ubuntu:16.04  
MAINTAINER tilldettmering@gmail.com  
  
RUN apt-get update &&\  
apt-get install --no-install-recommends -qy \  
texlive \  
texlive-lang-german \  
texlive-latex-extra \  
texlive-science \  
fonts-texgyre \  
tex-gyre \  
texlive-font-utils \  
texlive-fonts-extra \  
ps2eps \  
psutils \  
pandoc \  
gv \  
pdftk \  
latexmk &&\  
apt-get clean -y && rm -rf /var/lib/apt/lists/*  

