FROM bardiir/web-optim:tools  
  
COPY ./optimize.sh /app/optimize.sh  
  
WORKDIR /in

