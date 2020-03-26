FROM bentojs/bentojs-node  
  
RUN useradd --user-group --create-home --shell /bin/false app  
  
ENV HOME=/home/app  
ENV NODE_ENV=production  
  
COPY package.json $HOME/api/  
RUN chown -R app:app $HOME/*  
  
USER app  
WORKDIR $HOME/api  
RUN npm set progress=false && npm install --no-optional  
  
USER root  
COPY . $HOME/api  
RUN chown -R app:app $HOME/*  
USER app  
  
RUN node build.js  
  
CMD [ "npm", "run", "start" ]  

