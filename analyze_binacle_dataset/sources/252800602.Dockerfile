FROM dongjujang/iojs  
  
ADD . /iotorrent  
RUN npm install --prefix /iotorrent  
WORKDIR /iotorrent  
EXPOSE 8888  
CMD iojs app.js

