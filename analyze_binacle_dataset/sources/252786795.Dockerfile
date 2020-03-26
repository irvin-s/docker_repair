FROM golang  
RUN apt-get update -y  
RUN apt-get install graphviz -y  
ENTRYPOINT go  

