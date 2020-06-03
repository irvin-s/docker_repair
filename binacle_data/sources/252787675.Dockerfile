FROM java:7  
COPY src /home/root/tst/src  
WORKDIR /home/root/tst  
RUN mkdir bin  
RUN javac -d bin src/tst.java  
RUN rm -Rf src  
ENTRYPOINT ["java","-cp","bin","tst"]  
  

