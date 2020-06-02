FROM williamyeh/ansible:ubuntu16.04  
  
RUN apt-get update && apt-get install -y \  
rsync \  
&& rm -rf /var/lib/apt/lists/*

