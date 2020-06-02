FROM jupyter/all-spark-notebook  
MAINTAINER Marco Capuccini, marco.capuccini@it.uu.se  
  
USER root  
  
RUN pip install git+https://github.com/mcapuccini/luigi.git@feature/k8s-task  

