FROM bde2020/spark-worker:1.6.2-hadoop2.6  
  
RUN apt-get update \  
&& apt-get install -y libgfortran3

