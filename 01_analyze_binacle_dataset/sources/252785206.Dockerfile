# Provisioning  
FROM node  
RUN npm i -g bower brunch coffee-script  
  
ENV APP_PATH=/source  
  
RUN mkdir $APP_PATH  
WORKDIR $APP_PATH  
  
# npm  
ADD package.json $APP_PATH  
RUN npm install  
  
# bower  
ADD bower.json $APP_PATH  
RUN echo '{ "allow_root": true }' > /root/.bowerrc  
RUN bower install  
  
# brunch build  
COPY . $APP_PATH  
VOLUME $APP_PATH/public  
  
CMD \  
PUBLIC_DIR=./tmp_public brunch b -p -d; \  
rm -rf $APP_PATH/public/*; \  
cp -r ./tmp_public/* $APP_PATH/public/;  

