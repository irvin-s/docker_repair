#  
# DEER Dockerfile  
# https://github.com/kvndrsslr/deer_dockerized  
#  
# pull base image.  
FROM maven:3-jdk-8  
# maintainer details  
MAINTAINER Kevin Dreßler "dressler@informatik.uni-leipzig.de"  
RUN \  
export DEBIAN_FRONTEND=noninteractive && \  
mkdir -p /local  
  
# for now we need to download limes and build it ourselves  
WORKDIR /local  
  
RUN apt-get update && apt-get install -y openjfx  
  
# get DEER repository and run maven  
RUN git clone https://github.com/SLIPO-EU/DEER.git  
  
WORKDIR /local/DEER  
  
RUN \  
mvn clean compile assembly:assembly && \  
mv target/deer-0.5.0-jar-with-dependencies.jar ../deer.jar  
  
# attach volumes  
VOLUME /volume/data  
  
WORKDIR /volume/data  
  
# set an entrypoint for use as executable  
ENTRYPOINT ["java", "-jar", "/local/deer.jar"]  
  
# run with default parameter of "config.ttl"  
CMD ["config.ttl"]  
  
# run terminal  
#CMD ["/bin/bash"]  

