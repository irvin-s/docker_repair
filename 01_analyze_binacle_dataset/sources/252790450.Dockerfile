FROM cardinalsoftwaresolutions/nginx-node-bower-ember  
  
COPY deploy/nginx.conf /etc/nginx/nginx.conf  
  
# Copy application files and set working dir  
RUN mkdir /sho-bows-client  
COPY . /sho-bows-client  
WORKDIR /sho-bows-client  
  
RUN npm set progress=false && npm install  
RUN bower --allow-root install  
  
# Rebuild node-sass due to some node versioning possible conflicts  
RUN npm rebuild node-sass  
  
#TODO: Run ember tests  
# Building  
RUN ember build --environment=production  
  
# Copy dist to nginx for hosting  
RUN cp -a /sho-bows-client/dist/. /usr/share/nginx/html  

