FROM monostream/nodejs-gulp-bower  
MAINTAINER Paolo Casciello <paolo.casciello@scalebox.it>  
  
RUN apk add --no-cache \  
python py-pip \  
build-base autoconf automake nasm \  
zlib-dev libjpeg libpng giflib \  
&& \  
pip install --upgrade pip && \  
pip install --upgrade flask flask_babel setuptools && \  
# apk del py-pip && \  
yarn cache clean && \  
rm -rf /var/cache/* /tmp/*  
  
COPY ./gulpfile.js /workspace/  
COPY ./gulp /workspace/gulp  
COPY ./package.json /workspace/  
  
RUN npm update  
  
# Cleanup build tools to save image footprint  
RUN apk del build-base autoconf automake nasm  
  
CMD ["gulp", "monitor"]  

