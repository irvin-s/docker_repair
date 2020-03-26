FROM java  
COPY src/main/java/*.java /  
RUN javac *.java  
CMD java Invoker

