FROM ubuntu:16.04  
#FROM python:2.7  
MAINTAINER Soichi Hayashi <hayashis@iu.edu>  
  
RUN apt-get update && apt-get install -y python-pip  
RUN pip install numpy cython scipy matplotlib h5py nibabel nipype  
RUN pip install cvxpy scikit-learn  
RUN pip install dipy==0.13.0  
  
#make it work under singularity  
RUN ldconfig && mkdir -p /N/u /N/home /N/dc2 /N/soft  
  
#https://wiki.ubuntu.com/DashAsBinSh  
RUN rm /bin/sh && ln -s /bin/bash /bin/sh  

