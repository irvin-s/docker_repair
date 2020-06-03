FROM dankempster/node:latest  
  
RUN npm install webpack -g;  
  
USER www-data  
  
#ENTRYPOINT bower  
CMD [ "webpack" ]

