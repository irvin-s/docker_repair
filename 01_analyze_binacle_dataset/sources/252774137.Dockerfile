FROM python:2.7  
MAINTAINER Abdelhak Marouane <abdelhake@marouanefamily.com>  
  
RUN useradd -ms /bin/bash pylambda  
  
USER pylambda  
  
ENV HOME=/home/pylambda  
  
RUN mkdir $HOME/workStation && \  
pip install --user --no-cache-dir python-lambda && \  
pip install awscli --upgrade --user  
  
ENV PATH=/home/pylambda/.local/bin:$PATH  
  
VOLUME $HOME/workStation  
  
WORKDIR $HOME/workStation  
  
ENTRYPOINT /bin/bash  

