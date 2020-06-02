FROM ubuntu:latest  
  
ENV HOME /config  
ENV APPLE_ID steve@mac.com  
  
# Install base packages  
RUN apt-get update \  
&& apt-get dist-upgrade -y \  
&& apt-get install -y python-pip git \  
&& pip install --upgrade pip setuptools  
  
# Install icloud_photos_downloader  
RUN cd /usr/src \  
&& git clone https://github.com/chadj/icloud_photos_downloader.git \  
&& cd icloud_photos_downloader \  
&& git pull \  
&& git checkout ckdatabasews \  
&& pip install -r requirements.txt  
  
COPY run.sh /usr/bin/run.sh  
RUN chmod +x /usr/bin/run.sh  
  
VOLUME /photos /config  
  
ENTRYPOINT /usr/bin/run.sh  

