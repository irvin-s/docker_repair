FROM base/archlinux  
LABEL maintainer="luis@decomputed.com"  
  
## Update pacman  
RUN pacman -Syyu --noconfirm  
  
## Install make, which is useful to run complex builds  
RUN pacman -S --noconfirm --noprogressbar --needed make  
  
## Install tex-related thing  
RUN pacman -S --noconfirm --noprogressbar --needed texlive-bin  
  
## Workdir will be `sources`  
WORKDIR /sources

