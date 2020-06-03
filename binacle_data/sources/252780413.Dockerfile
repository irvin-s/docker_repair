FROM java:8  
COPY src /src  
COPY build.gradle /build.gradle  
COPY settings.gradle /settings.gradle  
COPY gradlew /gradlew  
COPY gradle /gradle  
  
RUN /gradlew prepareDocker  
RUN rm -rf src/  
RUN rm -rf .gradle/  
RUN rm -rf $HOME/.gradle/caches/  
  
COPY image/conf /conf  
COPY image/run.sh run.sh  
  
#web  
EXPOSE 4567  
ENTRYPOINT ["/run.sh"]

