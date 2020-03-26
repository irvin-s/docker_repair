FROM openjdk:8-jdk-alpine

ARG app=app

#ENV SPRING_PROFILES_DEFAULT=dual

ENV CONTAINER=docker

ENV TZ=Asia/Shanghai

VOLUME ["/root/${app}/conf"] 

WORKDIR /root

ADD target/ROOT.war ROOT.war

RUN apk add tzdata && ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#RUN apk add ca-certificates ttf-dejavu

EXPOSE 8080

ENTRYPOINT ["java","-server","-Xms128m","-Xmx1024m","-Xmn80m","-Xss256k","-XX:+UseG1GC","-XX:MaxGCPauseMillis=200","-XX:ParallelGCThreads=10","-XX:ConcGCThreads=2","-XX:InitiatingHeapOccupancyPercent=70","-Djava.awt.headless=true","-Djava.security.egd=file:/dev/./urandom","-jar","ROOT.war"]

#docker build --build-arg app=${app} -t ${app} .
#docker run -d -p 8080:8080 --volume ~/${app}/conf:/root/${app}/conf --name ${app} ${app}