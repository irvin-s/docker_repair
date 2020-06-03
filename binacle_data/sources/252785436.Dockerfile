FROM colstrom/alpine  
  
COPY assets/certstrap-static /usr/local/bin/certstrap  
  
ENTRYPOINT ["certstrap"]  
  
CMD ["help"]  

