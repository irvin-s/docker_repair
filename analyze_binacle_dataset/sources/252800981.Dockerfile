FROM phablet/ubuntu-sdk:vivid  
  
RUN dpkg --add-architecture i386 \  
&& apt-get update \  
&& apt-get -y --force-yes --no-install-recommends install \  
libconnectivity-qt1-dev \  
libaccounts-qt5-dev \  
libsignon-qt5-dev \  
&& apt-get clean \  
&& rm -f /var/lib/apt/lists/*_dists_*  

