FROM scratch  
  
COPY ./bin/codefight_server /codefight_server  
  
EXPOSE 3000  
ENV PORT=3000  
ENTRYPOINT ["/codefight_server"]  

