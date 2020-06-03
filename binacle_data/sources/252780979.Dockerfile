FROM ubuntu:12.04  
  
RUN apt-get update && apt-get -yq upgrade  
  
RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install \  
mercurial \  
mc \  
emacs \  
emacs-goodies-el \  
php-elisp \  
screen \  
nano \  
openssh-client \  
iputils-ping \  
less \  
ipset \  
gpw \  
pwgen \  
git-core  
  
ENV TERM xterm  

