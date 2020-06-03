FROM dongjujang/iojs  
  
ADD . /torrent_webhook  
RUN npm install --prefix /torrent_webhook  
WORKDIR /torrent_webhook  
EXPOSE 8888  
CMD iojs app.js

