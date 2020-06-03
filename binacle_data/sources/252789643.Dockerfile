FROM ubuntu:latest  
LABEL maintainer="sebas"  
# update the package manager  
RUN apt-get update && apt-get -y install curl && apt-get clean  
  
# curl parrot.live  
CMD ["curl", "parrot.live"]

