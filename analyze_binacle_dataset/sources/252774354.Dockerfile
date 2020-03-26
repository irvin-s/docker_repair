# latest official java image  
FROM maven:3-jdk-8  
RUN apt-get update  
  
# latest official nodejs executable  
RUN curl -sL https://deb.nodesource.com/setup_5.x | bash -  
RUN apt-get install -y nodejs  
  
# installing utility packages  
RUN apt-get install bzip2

