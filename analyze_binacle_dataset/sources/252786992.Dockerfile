FROM ubuntu  
MAINTAINER Jacques Supcik <jacques@supcik.net>  
  
RUN apt-get update && apt-get install -y \  
libconfig-general-perl \  
libtemplate-perl \  
texlive \  
texlive-lang-french \  
texlive-latex-extra \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY build-envelope /usr/local/bin/build-envelope

