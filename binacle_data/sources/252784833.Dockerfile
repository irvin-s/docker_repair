FROM codekoala/arch  
MAINTAINER Josh VanderLinden <codekoala@gmail.com>  
  
# allow build to pick up after this point if we update go  
RUN pacman -Sy --noconfirm --needed \  
openssh \  
bzr git mercurial subversion godep \  
gcc \  
upx \  
make tup  
  
RUN pacman -Sy --noconfirm --needed instarch/go  

