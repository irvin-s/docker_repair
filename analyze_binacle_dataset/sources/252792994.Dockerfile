FROM google/debian:wheezy  
  
MAINTAINER "Daniel Whatmuff" <danielwhatmuff@gmail.com>  
  
RUN apt-get update && \  
apt-get install -y --no-install-recommends p7zip-full && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* && \  
7z -h  
  
CMD ["7z"]  

