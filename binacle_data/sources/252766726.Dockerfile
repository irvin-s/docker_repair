FROM python:3.5  
MAINTAINER Arne Küderle <a.kuederle@gmail.com>  
  
RUN apt-get update && apt-get install -y texlive-full  
RUN rm -rf /var/lib/apt/lists/*  
RUN pip install --upgrade pip  

