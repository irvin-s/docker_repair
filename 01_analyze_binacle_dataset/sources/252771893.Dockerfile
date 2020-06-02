FROM ubuntu:latest  
RUN date > date.txt  
CMD sh -c 'cat date.txt; date'  

