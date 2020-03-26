FROM java:7  
  
RUN apt-get update  
  
#RUN apt-get install -y vim  
  
#RUN apt-get install -y wget  
  
#RUN sudo apt-get install -y openjdk-7-jdk  
  
RUN mkdir -p PROJET/BIN  
  
#COPY HelloWorld.java PRJET/SRC/.  
COPY HelloWorld.java PROJET/SRC/HelloWorld.java  
#RUN javac -s PROJET/BIN PROJET/SRC/HelloWorld.java  
#RUN javac PROJET/SRC/HelloWorld.java  
RUN javac -d PROJET/BIN PROJET/SRC/HelloWorld.java  
#ENTRYPOINT java PROJET/BIN/HelloWorld  
#ENTRYPOINT java -p PROJET/SRC/HelloWorld  
ENTRYPOINT java -cp PROJET/BIN HelloWorld  

