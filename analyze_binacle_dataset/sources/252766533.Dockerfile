FROM akiel/lens-clojure:0.1  
COPY dev /app/dev  
COPY resources /app/resources  
COPY src /app/src  
COPY project.clj /app/  
COPY docker/start.sh /app/  
  
WORKDIR /app  
  
RUN lein with-profile production deps  
RUN chmod +x start.sh  
  
EXPOSE 80  
CMD ["./start.sh"]  

