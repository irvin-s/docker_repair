FROM redis  
  
RUN touch hello.txt  
  
CMD ls hello.txt  

