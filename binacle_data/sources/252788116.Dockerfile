FROM ruby:2.3.3-slim  
  
MAINTAINER CreatekIO  
  
RUN apt-get update && \  
apt-get install -y \  
git \  
curl \  
build-essential \  
imagemagick \  
libicu-dev \  
libmagickwand-dev \  
libmysqlclient-dev \  
libqt5webkit5-dev \  
npm \  
qt5-default \  
wkhtmltopdf \  
xvfb \  
&& \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \  
ln -sf /usr/lib/x86_64-linux-gnu/ImageMagick-6.8.9/bin-Q16/* \  
/usr/local/bin/ && \  
mkdir -p /app  
  
CMD ["/bin/bash"]  

