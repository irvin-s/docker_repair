FROM dockerfile/nodejs  
ADD . /data  
RUN npm install --production && npm rebuild --production  
CMD node . -u $BD_URI -d $BD_DEST -m $BD_MAX -n $BD_MIN  
  

