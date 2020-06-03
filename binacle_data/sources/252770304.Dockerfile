FROM asgard/spark-grobid  
  
ADD . /home/pdf-parser  
WORKDIR /home/pdf-parser  
  
# built jar  
RUN sbt assembly  
# target/scala-2.10/grobid-spark-papers-assembly-1.4.1.jar  
RUN mkdir /tmp/spark-events  
  
CMD [/sbin/init_script]  

