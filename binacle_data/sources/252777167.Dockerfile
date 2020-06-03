FROM nginx  
  
WORKDIR /usr/src  
  
ADD . /usr/src/  
  
RUN chmod +x run.sh  
  
CMD ./run.sh  

