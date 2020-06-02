# Chromium Browser running in a Virtual FrameBuffer  
# Based on: https://github.com/mark-adams/docker-chromium-xvfb  
FROM node:5  
MAINTAINER JD Courtoy jd.courtoy@leankit.com  
  
RUN apt-get update && \  
apt-get install -y xvfb chromium && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
COPY xvfb-chromium /usr/bin/xvfb-chromium  
RUN ln -s /usr/bin/xvfb-chromium /usr/bin/google-chrome && \  
ln -s /usr/bin/xvfb-chromium /usr/bin/chromium-browser  
  
CMD [ "echo", "node --version" ]  

