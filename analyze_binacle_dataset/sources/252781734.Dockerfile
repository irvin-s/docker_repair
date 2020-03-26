FROM ubuntu:14.04.3  
  
MAINTAINER Chris Daish <chrisdaish@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
COPY AptSources /etc/apt/sources.list.d/  
  
RUN useradd -m google-chrome; \  
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A040830F7FAC5991 \  
&& apt-get update \  
&& apt-get install -y --no-install-recommends ca-certificates \  
gconf-service \  
hicolor-icon-theme \  
libappindicator1 \  
libasound2 \  
libcurl3 \  
libexif-dev \  
libgconf-2-4 \  
libgl1-mesa-dri \  
libgl1-mesa-glx \  
libnspr4 \  
libnss3 \  
libpango1.0-0 \  
libv4l-0 \  
libxss1 \  
libxtst6 \  
xdg-utils \  
google-chrome-stable=50.0.2661.94-1 \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY start-google-chrome.sh /usr/local/bin/  
  
ENTRYPOINT ["/usr/local/bin/start-google-chrome.sh"]  

