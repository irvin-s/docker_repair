FROM node:boron  
  
RUN mkdir /temp  
COPY package.json /temp/package.json  
RUN cd /temp && \  
npm install npm@5 && \  
rm -rf /usr/local/lib/node_modules && \  
mv node_modules /usr/local/lib/ && \  
cd ~ && \  
rm -rf /temp  
  
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils  
RUN apt-get install git  
RUN apt-get install -y libelf1  
RUN npm -v  
RUN node -v

