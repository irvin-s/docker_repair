############################################################  
# Dockerfile: Java docker for building ant Projects  
# Pull from carbonsphere/dock-ant  
# Usage: mount source with build.xml in /src  
# $ docker run --rm -v $(pwd):/src carbonsphere/dock-ant  
############################################################  
FROM java  
  
MAINTAINER CarbonSphere <CarbonSphere@gmail.com>  
  
RUN apt-get update && apt-get install -y ant  
  
RUN mkdir /src  
  
WORKDIR /src  
  
CMD ["ant"]  

