FROM ubuntu:latest  
  
ENV REVISION 2.5  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update && \  
# Runtime deps  
apt-get install -y zsh sudo gnupg cryptsetup pinentry-curses && \  
# Build deps  
apt-get install -y curl build-essential && \  
# Unlisted deps that docker doesn't have  
apt-get install -y gettext lsof && \  
# Cleanup docker  
apt-get clean  
  
# Build and install the specified version  
RUN cd /tmp && \  
echo Building tomb ${REVISION} && \  
curl -L https://files.dyne.org/tomb/Tomb-${REVISION}.tar.gz | tar -xz && \  
cd Tomb-${REVISION} && \  
make install && \  
cd .. && \  
rm -r Tomb-${REVISION}  
  
VOLUME /tomb  
WORKDIR /tomb

