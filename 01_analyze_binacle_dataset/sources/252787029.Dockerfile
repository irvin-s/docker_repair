#FROM brainlife/mcr:centos6-r2016a  
#FROM brainlife/mcr:centos6-r2017a  
FROM brainlife/mcr:neurodebian1604-r2017a  
  
MAINTAINER Soichi Hayashi <hayashis@iu.edu>  
  
#for openmp  
#RUN yum -y update && yum install -y libgomp  
RUN apt-get -qq install -y libgomp1  
  
ADD /msa-r2017a /app  
  
#we want all output to go here (config.json should also go here)  
WORKDIR /output  
  
#http://singularity.lbl.gov/docs-docker#be-practices  
RUN ldconfig  
  
ENTRYPOINT ["/app/main"]  
  

