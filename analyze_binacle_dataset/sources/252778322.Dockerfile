# -*- mode: ruby -*-  
# vi: set ft=ruby :  
FROM aquabiota/realm-tidyverse:latest  
  
## Add LaTeX, rticles and bookdown support  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends \  
default-jdk \  
ghostscript \  
libbz2-dev \  
libicu-dev \  
liblzma-dev \  
libhunspell-dev \  
libmagick++-dev \  
librdf0-dev \  
libv8-dev \  
qpdf \  
ssh \  
lmodern \  
texlive-fonts-recommended \  
texlive-generic-recommended \  
texlive-humanities \  
texlive-latex-extra \  
texlive-science \  
texlive-xetex \  
texinfo \  
less \  
vim \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/ \  
&& cd /usr/share/texlive/texmf-dist/tex/latex \  
&& wget http://mirrors.ctan.org/macros/latex/contrib/ametsoc.zip \  
&& unzip ametsoc.zip \  
&& rm *.zip \  
&& cd /usr/share/texlive/texmf-dist \  
&& wget http://mirrors.ctan.org/install/fonts/inconsolata.tds.zip \  
&& unzip inconsolata.tds.zip \  
&& rm *.zip \  
&& echo "Map zi4.map" >> /usr/share/texlive/texmf-dist/web2c/updmap.cfg \  
&& mktexlsr \  
&& updmap-sys \  
&& install2.r -r http://rforge.net PKI rocr \  
&& install2.r --error --deps TRUE \  
bookdown rticles rmdshower webshot flexdashboard DT  
# Required by webshot to detect HTML widgets  
RUN echo "Rscript -e 'webshot::install_phantomjs()'"  
  
## Consider including:  
# - yihui/printr R package (when released to CRAN)  
# - libgsl0-dev (GSL math library dependencies)  
# - librdf0-dev  

