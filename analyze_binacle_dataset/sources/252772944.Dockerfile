FROM node:6  
ADD ./frontend/package.json /home/httpd/frontend/package.json  
WORKDIR /home/httpd/frontend  
  
RUN npm install http-server@0.9.0 && \  
npm install && \  
cp -r node_modules ../  
  
ADD ./frontend /home/httpd/frontend  
WORKDIR /home/httpd/frontend  
  
RUN cp -r ../node_modules ./ && node_modules/gulp/bin/gulp.js build  
  
CMD node node_modules/http-server/bin/http-server static -p 80 --cors  

