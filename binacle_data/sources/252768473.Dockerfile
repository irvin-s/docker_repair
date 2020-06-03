FROM node:8  
RUN apt-get update && \  
apt-get install -y curl bzip2 libfreetype6 libfontconfig  
  
COPY ./scripts/ /opt/app  
WORKDIR /opt/app  
  
RUN yarn  
  
ENV PATH=/opt/app/node_modules/phantomjs-prebuilt/lib/phantom/bin:$PATH  
  
CMD ["node", "index.js"]  

