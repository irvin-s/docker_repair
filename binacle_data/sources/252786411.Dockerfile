FROM docker4labs/node-opencv  
  
RUN export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig  
RUN ln /dev/null /dev/raw1394  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
COPY package.json /usr/src/app/  
RUN npm install  
COPY . /usr/src/app  
EXPOSE 8686  
CMD ["npm", "start"]  
  

