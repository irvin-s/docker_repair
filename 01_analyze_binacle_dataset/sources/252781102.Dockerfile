FROM openjdk:10.0.1-10-jre  
  
RUN apt-get update && apt-get install -y \  
graphicsmagick \  
ffmpeg \  
&& rm -rf /var/lib/apt/lists/*  

