FROM node:6.5.0  
  
# Install freetype for phantomjs  
RUN \  
apt-get update && \  
apt-get install -y libfreetype6 libfontconfig && \  
apt-get clean && \  
  
#  
# Fix multiple `npm install` cross-linking issues  
# See: https://github.com/npm/npm/issues/9863  
#  
#cd $(npm root -g)/npm && \  
#npm install fs-extra && \  
#sed -i -e s/graceful-fs/fs-extra/ -e s/fs\\.rename/fs.move/
./lib/utils/rename.js && \  
  
# npm install -g npm@3.10.8 && \  
npm install -g bower grunt-cli forever phantomjs && \  
npm cache clean

