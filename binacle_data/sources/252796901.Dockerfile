FROM node:8-alpine  
  
RUN mkdir /src  
RUN npm install -g \  
eslint \  
eslint-plugin-json \  
&& rm -rf /root/.npm  
  
ADD .eslintrc.json /src/.eslintrc.json  
WORKDIR /src  
ENTRYPOINT ["/usr/local/bin/eslint"]  
  

