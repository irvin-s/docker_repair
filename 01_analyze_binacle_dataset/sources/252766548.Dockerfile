# ZooKeeper with dynamic configuration (see README.md)  
FROM java:7  
MAINTAINER akihirosuda  
  
ENV JAVA_TOOL_OPTIONS -Dfile.encoding=UTF8  
RUN mkdir /zk /zk_data  
ADD zookeeper /zk  
ADD init.py /  
WORKDIR /zk  
  
RUN apt-get update && apt-get install -y ant && ant  
CMD ["python", "/init.py"]  
EXPOSE 2181 2888 3888  

