FROM node:8.9  
LABEL maintainer=TBSx3 \  
version=1.0 \  
author=CY  
  
RUN apt-get -qq update \  
&& apt-get install -qq -y \  
libgtk2.0-0 \  
libnotify-dev \  
libgconf-2-4 \  
libnss3 \  
libxss1 \  
libasound2 \  
xvfb \  
lsof  
  
RUN yarn global add firebase-tools --silent > /dev/null  

