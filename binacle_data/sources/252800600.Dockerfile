FROM dongjujang/iojs  
  
ADD . /dockerhub-slack  
RUN npm install --prefix /dockerhub-slack  
WORKDIR /dockerhub-slack  
EXPOSE 8888  
CMD iojs app.js

