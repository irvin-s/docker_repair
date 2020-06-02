FROM sitespeedio/webbrowsers:firefox-54.0-chrome-60.0  
ENV SITESPEED_IO_BROWSERTIME__XVFB true  
ENV SITESPEED_IO_BROWSERTIME__CHROME__ARGS no-sandbox  
  
RUN addgroup --system --gid 2718 ppoker && \  
adduser --system --uid 2718 --gid 2718 --home /usr/src/app ppoker  
  
RUN usermod -aG sudo ppoker  
  
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers  
  
## This is to avoid click the OK button  
RUN mkdir -m 0750 /root/.android  
ADD docker/adb/insecure_shared_adbkey /root/.android/adbkey  
ADD docker/adb/insecure_shared_adbkey.pub /root/.android/adbkey.pub  
  
USER ppoker  
  
#RUN mkdir -p /usr/src/ppoker  
WORKDIR /usr/src/app  
  
COPY package.json /usr/src/app/  
RUN npm install --production  
COPY . /usr/src/app  
  
COPY docker/scripts/start.sh /start.sh  
  
ENTRYPOINT ["/start.sh"]  
VOLUME /sitespeed.io  
WORKDIR /sitespeed.io  

