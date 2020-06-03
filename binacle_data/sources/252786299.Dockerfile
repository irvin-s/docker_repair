FROM node:8.11  
  
LABEL maintainer="Moss team <devops@moss.sh>"  
# install cypress dependencies  
RUN apt-get update \  
&& apt-get install -y \  
libgtk2.0-0 \  
libnotify-dev \  
libgconf-2-4 \  
libnss3 \  
libxss1 \  
libasound2 \  
xvfb \  
zip \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
## a few environment variables to make NPM installs easier  
# good colors for most applications  
ENV TERM xterm  
# avoid million NPM install messages  
ENV npm_config_loglevel warn  
# allow installing when the main user is root  
ENV npm_config_unsafe_perm true  

