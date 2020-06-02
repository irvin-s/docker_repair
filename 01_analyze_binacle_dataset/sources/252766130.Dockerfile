FROM ubuntu:14.04  
MAINTAINER Adrien Anceau <adrien.anceau@gmail.com>  
  
# Install needed tools  
RUN apt-get update \  
&& apt-get install -y git qt5-qmake gcc make g++  
  
# Build project  
RUN git clone ${BRANCH:+-b $BRANCH} https://github.com/simulationcraft/simc \  
&& cd simc/engine \  
&& make \  
&& mv /simc/engine/simc /bin/simc \  
&& rm -fr /simc  
  
ENTRYPOINT ["/bin/simc"]  

