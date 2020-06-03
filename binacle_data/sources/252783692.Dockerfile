FROM cgswong/vault:latest  
  
# move config file  
COPY ./lounge.json /app/vault  
  
# run server with config  
CMD ["server" "-config=/app/vault"]  

