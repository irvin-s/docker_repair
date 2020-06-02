FROM ghost  
RUN npm install ghost-s3-storage --save  
ADD index.js $GHOST_SOURCE/content/storage/ghost-s3/index.js

