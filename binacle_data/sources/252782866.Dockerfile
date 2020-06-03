FROM geekykaran/headless-chrome-node-docker:latest  
MAINTAINER David J Eddy <me@davidjeddy.com>  
COPY ./ /app  
WORKDIR /app  
RUN npm install babel-core babel-jest babel-preset-env jest puppeteer  
CMD ["npm", "test"]  

