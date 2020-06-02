FROM openjdk:10.0.1-10-jre  
  
RUN apt-get update && apt-get install -y \  
imagemagick \  
ffmpeg \  
&& rm -rf /var/lib/apt/lists/*  
# COPY policy.xml /etc/ImageMagick-7/  

