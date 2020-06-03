from aallam/maven:3.5  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
ONBUILD ADD . /usr/src/app  
  
ONBUILD RUN mvn install  

