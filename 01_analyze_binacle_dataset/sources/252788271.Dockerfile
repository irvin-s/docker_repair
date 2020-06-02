# Hydra Eye image, based on EYE of Jos and EYE Server by Ruben  
# http://eulersharp.sourceforge.net/  
FROM bdevloed/eye:latest  
MAINTAINER Cristian Vasquez <cristianvasquez@gmail.com>  
  
# Install latest nodejs  
RUN apt-get -qq update && \  
apt-get -qqy --no-install-recommends install gnupg && \  
curl -fsSL https://deb.nodesource.com/setup_8.x | bash - && \  
apt-get install -qy nodejs && \  
apt-get install -qy git && \  
apt-get install -qy wget && \  
apt-get purge -qy lsb-release && \  
apt-get -qy autoremove && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
# Install hydra eye server  
WORKDIR /usr/src/app  
  
RUN npm -g install hes-agent  
  
EXPOSE 3000  
ENTRYPOINT hes serve ./workspace

