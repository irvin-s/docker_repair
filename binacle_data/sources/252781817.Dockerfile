FROM ubuntu:latest  
  
# Install base packages  
RUN apt-get update \  
&& apt-get dist-upgrade -y \  
&& apt-get install -y curl unzip  
  
RUN mkdir /app \  
&& cd /app \  
&& curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip \  
&& unzip rclone-current-linux-amd64.zip \  
&& ln -s /app/rclone-*-linux-amd64/rclone /app/rclone  
  
ENTRYPOINT ["/app/rclone"]  
CMD ["help"]  

