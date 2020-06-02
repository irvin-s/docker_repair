FROM mhart/alpine-node:8.2.0  
ADD ./test-http /app  
  
WORKDIR /app  
  
RUN npm set progress=false \  
&& npm install \  
&& npm run build \  
&& rm -rf node_modules  
  
EXPOSE 8080  
CMD npm start

