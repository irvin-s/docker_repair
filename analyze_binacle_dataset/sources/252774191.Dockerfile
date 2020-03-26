FROM node:8-alpine  
  
ENV NODE_PATH /usr/local/lib/node_modules  
  
RUN apk --no-cache add --virtual native-deps \  
g++ gcc libgcc libstdc++ linux-headers make python curl git && \  
npm install -g --silent protractor && \  
npm install -g --silent protractor-jasmine2-screenshot-reporter && \  
npm install -g --silent protractor-screenshoter-plugin && \  
npm install -g --silent jasmine-spec-reporter && \  
npm install -g --silent protractor-console-plugin && \  
npm install -g --silent node-rest-client && \  
npm install -g --silent node-rest-client-promise && \  
npm install -g --silent chai && \  
npm install -g --silent chai-as-promised && \  
npm install -g --silent babel-eslint && \  
npm install -g --silent eslint && \  
npm install -g --silent mocha && \  
npm install -g --silent nock && \  
npm install -g --silent nyc && \  
npm install -g --silent sinon && \  
npm install -g --silent codeclimate-test-reporter && \  
npm install -g --silent dotenv

