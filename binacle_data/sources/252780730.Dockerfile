FROM zenato/puppeteer  
ENV PORT 3000  
#ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true  
USER root  
ADD package.json /tmp/package.json  
RUN cd /tmp && npm install  
RUN mkdir -p /app && cp -a /tmp/node_modules /app/  
EXPOSE 3000  
WORKDIR /app  
COPY . /app  
CMD npm run start  

