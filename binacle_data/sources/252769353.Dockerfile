FROM scratch  
  
COPY snotver /snotver  
  
ENTRYPOINT ["/snotver"]

