FROM continuumio/miniconda3  
MAINTAINER Arne Johanson  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
RUN conda update --all -y  
RUN conda install numpy flask -y  
  
COPY . /usr/src/app  
  
EXPOSE 3336  
CMD ["python3","server.py","--acceptAllHosts"]  

