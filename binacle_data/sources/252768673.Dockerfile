# Usage:  
# docker build -t andaag/sklearn_notebook3 .  
# mkdir ml  
# docker run -v $(pwd)/ml:/ml -t andaag/sklearn_notebook3  
FROM ubuntu:15.04  
ENV DEBIAN_FRONTEND noninteractive  
RUN locale-gen en_US en_US.UTF-8  
ENV PATH=/opt/conda/bin:${PATH}  
ENV JOBLIB_TEMP_FOLDER /tmp  
  
RUN mkdir /ml && chmod 755 /ml  
COPY install.sh /tmp/install.sh  
COPY req.txt /tmp/req.txt  
RUN cd /tmp && bash install.sh 3 && rm /tmp/*  
  
VOLUME /ml  
WORKDIR /ml  
  
EXPOSE 8888  
ENV PYTHONUNBUFFERED=1  
CMD jupyter notebook --no-browser --script --ip=0.0.0.0 --port 8888  

