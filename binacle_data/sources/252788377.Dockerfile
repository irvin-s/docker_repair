FROM google/nodejs-runtime  
  
RUN ./kiwi build  
  
EXPOSE 7778  
ENTRYPOINT ["./kiwi", "-f", "start"]  
CMD ["-c", "config.example.js"]  

