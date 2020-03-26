FROM ubuntu:latest  
MAINTAINER Fahmi Akbar Wildana <fahmi.akbar.w@mail.ugm.ac.id>  
  
RUN apt-get update \  
&& apt-get install -y curl openssh-server \  
build-essential git  
  
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -  
  
RUN apt-get install -y nodejs \  
pylint virtualenv \  
python3-dev python3-pip \  
python-pip python-dev  
  
# RUN npm install npm -g  
RUN pip install -U pip && pip3 install -U pip  
  
# Installing the packages needed to run Nightmare  
# https://github.com/segmentio/nightmare/issues/224#issuecomment-261322814  
RUN apt-get install -y \  
xvfb \  
x11-xkb-utils \  
xfonts-100dpi \  
xfonts-75dpi \  
xfonts-scalable \  
xfonts-cyrillic \  
x11-apps \  
clang \  
libdbus-1-dev \  
libgtk2.0-dev \  
libnotify-dev \  
libgnome-keyring-dev \  
libgconf2-dev \  
libasound2-dev \  
libcap-dev \  
libcups2-dev \  
libxtst-dev \  
libxss1 \  
libnss3-dev \  
gcc-multilib \  
g++-multilib  
  
# RUN rm -rf /usr/local/lib/node_modules \  
# && rm -rf ~/.npm \  
# && apt-get purge -y nodejs \  
# && apt-get install -y nodejs  
RUN npm install -g pm2 pm2-web \  
ddos-stress images-scraper \  
nightmare phantomjs  
RUN pip3 install ImageScraper GoogleScraper  
  
EXPOSE 9000  
# pm2 start --interpreter xvfb-run npm -- start  
CMD ['pm2-web']  

