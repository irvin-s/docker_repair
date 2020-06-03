from ubuntu  
  
env DEBIAN_FRONTEND noninteractive  
  
add http://pencil.evolus.vn/dl/V3.0.4/Pencil_3.0.4_amd64.deb /  
  
run dpkg -i /Pencil_3.0.4_amd64.deb && \apt-get update && \  
apt-get install -y libgtk2.0-0 libxtst6 libxss1 libgconf-2-4 libnss3-dev \  
libasound2 && \  
rm -rf /Pencil_3.0.4_amd64.deb /var/lib/apt/lists/*  
  
entrypoint pencil  

