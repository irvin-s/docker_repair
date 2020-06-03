FROM alekzonder/puppeteer:0.13.0  
# copy the package.json and yarn.lock file  
COPY package.json /app  
COPY yarn.lock /app  
  
# install the dependencies  
RUN yarn install --prod --ignore-optional  
  
# copy source code  
COPY . /app  
  
CMD [ "npm" , "test" ]  

