FROM mhart/alpine-node:9  
  
Maintainer Pascal Gafner <pascal.gafner@postfinance.ch>  
  
RUN yarn add protractor && \  
yarn add protractor-jasmine2-screenshot-reporter && \  
yarn add typescript && \  
yarn add jasmine-core && \  
yarn add jasmine-reporters && \  
rm -rf /var/lib/apt/lists/* \  
/var/cache/apk/* \  
/usr/share/man \  
/tmp/* \  
/usr/lib/node_modules/npm/man \  
/usr/lib/node_modules/npm/doc \  
/usr/lib/node_modules/npm/html \  
/usr/lib/node_modules/npm/scripts  
  
CMD ["/bin/sh"]  

