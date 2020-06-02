FROM base/archlinux:latest  
MAINTAINER Charles Samborski <demurgos@demurgos.net>  
RUN pacman -Syu \--quiet \--noconfirm \--noprogressbar \  
&& pacman -S \--quiet \--noconfirm \--noprogressbar \  
coreutils \  
expect \  
gcc \  
git \  
make \  
neko \  
ocaml \  
pcre \  
xorg-server-xvfb \  
zlib \  
&& pacman -Sc \--quiet \--noconfirm \--noprogressbar  
RUN pacman -Syu \--quiet \--noconfirm \--noprogressbar \  
&& pacman -S \--quiet \--noconfirm \--noprogressbar \  
nodejs \  
npm \  
yarn \  
&& npm install -g npm gulp-cli \  
&& pacman -Sc \--quiet \--noconfirm \--noprogressbar  
RUN pacman -Syu \--quiet \--noconfirm \--noprogressbar \  
&& pacman -S \--quiet \--noconfirm \--noprogressbar \  
jdk9-openjdk \  
&& pacman -Sc \--quiet \--noconfirm \--noprogressbar  
ENV JAVA_TOOL_OPTIONS -Dfile.encoding=UTF8  
  
CMD ["/bin/bash"]  

