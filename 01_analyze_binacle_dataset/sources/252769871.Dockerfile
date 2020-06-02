FROM arpasmr/r-base  
COPY . /usr/local/src/myscripts  
WORKDIR /usr/local/src/myscripts  
CMD ["./anag_prodotti.sh"]  

