FROM maven:3-jdk-8  
RUN adduser --disabled-password --gecos "" app  
ENV HOME /home/app  
WORKDIR /home/app/  
  
COPY . /home/app  
RUN mvn install -DskipTests  
  
USER app  
CMD bin/run_fetcher  

