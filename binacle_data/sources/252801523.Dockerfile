FROM node:7  
# Updating ubuntu packages  
ENV DEBIAN_FRONTEND noninteractive  
ENV DEBUG worker  
ENV NODE_ENV production  
ENV TZ America/Sao_Paulo  
  
RUN apt-get update  
  
# Installing the packages needed to run Nightmare  
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
  
# Add current directory to /app  
ADD . /app  
  
# Set current working directory as /app  
WORKDIR /app  
  
# Install npm packages  
RUN npm install --production --silent  
  
EXPOSE 3000  
CMD xvfb-run --server-args="-screen 0 1024x768x24" node index.js  

