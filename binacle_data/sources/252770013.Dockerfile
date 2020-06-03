FROM articulate/articulate-node:8  
RUN mkdir -p /app  
WORKDIR /app  
  
COPY package.json yarn.lock /app/  
  
RUN yarn install --pure-lockfile  
  
ADD . /app  
  
CMD yarn run server  
ENTRYPOINT ["yarn", "run", "client", "--"]  

