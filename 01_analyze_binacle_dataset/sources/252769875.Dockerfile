FROM arpasmr/r-base  
COPY . /usr/local/src/myscripts  
WORKDIR /usr/local/src/myscripts  
CMD ["./launch_recuperoRT-new.sh"]  

