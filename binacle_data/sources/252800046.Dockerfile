FROM java:7  
COPY src /home/learner/myimage/javahelloworld/src  
WORKDIR /home/learner/myimage/javahelloworld  
RUN mkdir bin  
RUN javac -d bin src/HelloWorld.java  
RUN apt-get update && apt-get install wget  
ENTRYPOINT ["java", "-cp", "bin", "HelloWorld" ]  
ENV FOO bar  
RUN echo $FOO  
RUN mkdir integration_test  

