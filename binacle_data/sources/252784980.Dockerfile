FROM python:2.7.10  
ENV LANGUAGE python  
ENV LANGUAGE_VERSION 2.7.10  
# Create /src directory and set it to cwd  
RUN mkdir /src  
WORKDIR /src  
  
# Create volume with host target directory  
RUN mkdir /user  
  
# Copy exercise repository into image  
ADD . /src/  
  
# Launch run.sh by default  
ENTRYPOINT ["bash", "./run.sh"]  

