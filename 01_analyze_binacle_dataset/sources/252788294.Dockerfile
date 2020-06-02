  
FROM criticalblue/nodejs  
  
  
# == Installs latest version of PhoneGap  
# Forces a create and build in order to preload libraries  
RUN npm install -g phonegap@latest && \  
npm install -g xmldom && \  
npm install -g xpath && \  
cd /tmp && \  
phonegap create fakeapp && \  
cd /tmp/fakeapp && \  
phonegap build android && \  
cd && \  
rm -rf /tmp/fakeapp  
  
VOLUME ["/data"]  
WORKDIR /data  
  
EXPOSE 3000  

