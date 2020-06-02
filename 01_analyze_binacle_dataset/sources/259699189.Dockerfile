FROM openjdk
COPY path-finder-1.0-swarm.jar /
WORKDIR /
EXPOSE 8888
CMD java -jar path-finder-1.0-swarm.jar