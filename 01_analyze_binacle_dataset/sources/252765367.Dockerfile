FROM mono  
RUN \  
apt-get update && \  
apt-get install -y mono-complete mono-xsp4 nuget && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* && \  
mkdir -p /var/www  

