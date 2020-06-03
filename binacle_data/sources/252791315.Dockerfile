FROM debian:latest  
RUN apt-get update && apt-get -y upgrade  
RUN apt-get -y install python3 python3-numpy python3-pandas  
  
RUN mkdir /scripts  
COPY scripts/ /scripts  
  
ENTRYPOINT ["python3", "/scripts/expression_filter.py"]

