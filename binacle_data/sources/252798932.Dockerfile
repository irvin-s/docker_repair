FROM devicetools/apidocs.server  
  
COPY buildAll.sh .  
COPY apiblueprint /apiblueprint  
  
RUN mkdir -p /public  
RUN ./buildAll.sh  
  
CMD ["http-server", "/public"]  

