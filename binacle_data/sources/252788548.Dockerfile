FROM japaric/x86_64-unknown-linux-gnu  
  
RUN apt-get update && \  
apt-get install -y libx11-dev libxcursor-dev libasound2-dev libudev-dev  

