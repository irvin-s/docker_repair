FROM node:alpine  
USER node  
WORKDIR /home/node  
RUN npm install -q yo  
COPY scripts /home/node/scripts  
RUN mkdir /home/node/src  
  
ENTRYPOINT ["./scripts/entrypoint.sh"]  
CMD ["react", "mocha"]

