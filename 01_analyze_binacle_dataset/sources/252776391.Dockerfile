# http://docs.docker.com/reference/builder  
# Updated base openSUSE 42.1 image.  
# \- boombatower/opensuse:42.1  
# \- boombatower/opensuse:leap  
  
FROM opensuse:42.1  
MAINTAINER Jimmy Berry <jimmy@boombatower.com>  
  
# Update base software.  
# No longer seems to work with simple `zypper update`.  
RUN zypper -n --gpg-auto-import-keys refresh && \  
zypper -n dist-upgrade  

