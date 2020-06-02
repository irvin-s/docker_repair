from ubuntu  
  
env DEBIAN_FRONTEND noninteractive  
  
run sed -i '/deb-src/d' /etc/apt/sources.list && \  
apt-get update && \  
apt-get install --yes wget python  
  
run useradd -m -d /dbox -s /bin/bash -u 1000 dbox  
  
run wget https://www.dropbox.com/download?dl=packages/dropbox.py -O \  
/usr/local/bin/dropbox && \  
chmod 755 /usr/local/bin/dropbox  
  
user dbox  
workdir /dbox  
copy install-dropbox.sh /usr/local/bin/  

