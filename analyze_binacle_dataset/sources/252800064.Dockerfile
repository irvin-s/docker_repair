from java:8  
RUN mkdir -p /src  
copy Test.java /src  
RUN javac /src/Test.java  
#cmd readlink -f Test.java  
cmd java -cp /src Test  
  

