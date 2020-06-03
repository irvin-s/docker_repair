FROM node:4.1-wheezy  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update -y  
  
RUN apt-get install --no-install-recommends -y -q \  
libfreetype6 \  
libfontconfig \  
bash \  
curl \  
python \  
bzip2 \  
zip \  
unzip \  
build-essential \  
git  
  
RUN unset DEBIAN_FRONTEND  
  
COPY scripts/npm-config.sh /usr/local/bin/npm-config  
RUN chmod +x /usr/local/bin/npm-config  
  
RUN /usr/local/bin/npm-config  
ENV HOME /root  
ENV PATH $PATH:$HOME/npm/bin  
  
RUN which node  
RUN node --version  
RUN npm --version  
  
RUN npm cache clean  
  
RUN npm install --silent --global tmi@1.0.3  
RUN npm install --silent --global psi@1.0.6  
  
RUN npm install --silent --global dnc@0.1.2  
  
COPY scripts/container-tools.sh /usr/local/bin/container-tools  
RUN chmod +x /usr/local/bin/container-tools  
  
CMD ["/usr/local/bin/container-tools"]  

