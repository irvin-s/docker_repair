FROM alekzonder/puppeteer:latest  
ADD . /paper-cutter  
RUN yarn global add /paper-cutter  

