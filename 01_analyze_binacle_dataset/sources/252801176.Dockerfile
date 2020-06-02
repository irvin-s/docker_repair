FROM dreid/tahoe-lafs-base  
  
RUN tahoe create-introducer /tahoe  
RUN echo "34567" > /tahoe/introducer.port  
EXPOSE 34567  
WORKDIR /tahoe  
ENTRYPOINT ["twistd"]  
CMD ["-ny", "tahoe-introducer.tac"]  

