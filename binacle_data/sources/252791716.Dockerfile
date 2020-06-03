# Contrainer  
#  
# VERSION 0.0.2  
#  
  
FROM dalguete/ubuntu-15-04-64  
MAINTAINER Daniel Dalgo <dalguete@gmail.com>  
  
# Remove some non required ppa packages  
RUN apt-get purge -y \  
githooks \  
keychain-starter \  
my-bindfs-mounts \  
pass-phrase \  
&& add-apt-repository \--remove -y \  
ppa:dalguete/githooks \  
&& add-apt-repository \--remove -y \  
ppa:dalguete/keychain-starter \  
&& add-apt-repository \--remove -y \  
ppa:dalguete/my-bindfs-mounts \  
&& add-apt-repository \--remove -y \  
ppa:dalguete/pass-phrase  
  
# Remove a bunch of non required packages  
RUN apt-get purge -y \  
build-essential \  
bsdmainutils \  
debconf-utils \  
git \  
mailutils \  
openssh-server \  
postfix \  
python-software-properties \  
rar \  
supervisor \  
unrar \  
zip \  
zsh  
  
# Remove other packages that should be explicitly mention for that  
RUN apt-get purge -y \  
gcc \  
python  
  
# Install contrainer  
RUN add-apt-repository -y ppa:dalguete/contrainer \  
&& apt-get update \  
&& apt-get install -y \  
contrainer  
  
# Cleaning up  
RUN apt-get autoremove --purge -y \  
&& apt-get autoclean -y \  
&& apt-get clean -y \  
&& rm -r /var/lib/apt/lists/*  
  
# Set the default command to run  
ENTRYPOINT exec /usr/bin/contrainer watch  
  
# Same as above, build for images built upon the one here created.  
ONBUILD ENTRYPOINT exec /usr/bin/contrainer watch  
  

