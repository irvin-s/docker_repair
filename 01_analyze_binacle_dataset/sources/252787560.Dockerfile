FROM debian:latest  
#RUN apt-key update  
RUN apt-get update  
RUN apt-get -y upgrade  
RUN apt-get -y install openjdk-8-jre openjdk-8-jdk  
WORKDIR /bot_src  
ADD . /bot_src/  
RUN chmod +x gradlew  
ENV PORT=8080  
ENV TOKEN=10  
RUN ./gradlew build  
CMD java -jar build/libs/DiscordBot-0.1.0.jar -t ${TOKEN}  

