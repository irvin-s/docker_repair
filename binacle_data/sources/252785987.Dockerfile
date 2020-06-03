FROM debian:sid  
RUN apt-get update && \  
apt-get install -y webkitgtk-3.0-dev webkit2gtk-4.0-dev libgnutls28-dev && \  
rm -rf /var/lib/apt/lists/*  

