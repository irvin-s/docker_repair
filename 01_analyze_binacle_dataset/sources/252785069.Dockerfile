FROM scratch  
  
LABEL services sys  
ADD pause /  
ENTRYPOINT ["/pause"]

