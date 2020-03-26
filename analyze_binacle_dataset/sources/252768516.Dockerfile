FROM mhart/alpine-node:8.9.3  
ENV NODE_ENV=production  
  
RUN addgroup -S appuser && adduser -S -g appuser appuser  
ENV HOME=/home/appuser  
USER appuser  
  
RUN mkdir $HOME/chat  
WORKDIR $HOME/chat  
  
COPY package.json $HOME/chat  
  
RUN npm install  
  
COPY . $HOME/chat  
  
EXPOSE 3000  
CMD ["node","server"]  

