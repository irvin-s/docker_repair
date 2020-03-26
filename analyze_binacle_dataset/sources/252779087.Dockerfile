FROM bwbush/devel  
  
MAINTAINER Brian W Bush <root@bwbush.io>  
  
WORKDIR /root/tmp  
  
RUN apt-get update \  
&& apt-get install --no-install-recommends --yes \  
g++ \  
gfortran \  
libblas-dev \  
libcairo2-dev \  
libgmp-dev \  
libgmp10 \  
libgmp3-dev \  
libgsl0-dev \  
libjpeg62 \  
liblapack-dev \  
libncurses5-dev \  
libreadline-dev \  
libx11-dev \  
libxt-dev \  
make \  
r-base \  
r-base-core \  
r-base-dev \  
r-cran-amelia \  
# r-cran-bnlearn \  
r-cran-ggplot2 \  
r-cran-mvtnorm \  
r-cran-plyr \  
r-cran-reshape2 \  
# r-cran-wmtsa \  
r-cran-zoo \  
texlive-fonts-extra \  
texlive-latex-base \  
zlib1g-dev \  
&& apt-get clean autoclean \  
&& apt-get autoremove --yes  
  
CMD R  

