FROM debian:8.0  
MAINTAINER andystanton  
ENV LANG C.UTF-8  
RUN apt-get -qq -y update && \  
apt-get install -y patch curl && \  
command curl -sSL https://rvm.io/mpapis.asc | gpg --import - && \  
\curl -sSL https://get.rvm.io | bash -s stable --ruby && \  
printf "\n%s\n" 'source /usr/local/rvm/scripts/rvm' >> /etc/bash.bashrc && \  
printf "\n%s\n" 'source /usr/local/rvm/scripts/rvm' >> /etc/profile && \  
apt-get remove -y curl && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
ADD image-common /tmp/dexec/image-common  
VOLUME /tmp/dexec/build  
ENTRYPOINT ["bash", "-l", "/tmp/dexec/image-common/dexec-script.sh", "ruby"]  

