FROM node:alpine  
  
RUN npm i -g yarn  
  
ADD package.json yarn.lock /tmp/  
ADD internals /tmp/internals  
  
RUN cd /tmp && yarn  
RUN mkdir -p /app && cd /app && ln -s /tmp/node_modules  
  
COPY . /app  
WORKDIR /app  
  
ENV FORCE_COLOR=1  
ENTRYPOINT ["npm"]  
CMD ["start"]  

