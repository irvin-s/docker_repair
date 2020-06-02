FROM devicetools/golib:2.2.3  
ENV CODE_PATH=/go/src/bitbucket.org/devicetools/download.server  
  
WORKDIR ${CODE_PATH}  
COPY . ${CODE_PATH}  
  
EXPOSE 80  
RUN go-wrapper download  
RUN go-wrapper install  
  
CMD ["go-wrapper", "run"]  

