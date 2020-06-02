FROM java  
  
RUN apt-get update && apt-get install -y ant  
  
RUN mkdir /src  
  
WORKDIR /src  
  
CMD ["ant"]  

