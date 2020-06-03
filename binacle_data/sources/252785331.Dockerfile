FROM colinfang/anaconda  
MAINTAINER Colin Fang <colinfang@live.com>  
  
ADD . /src  
  
RUN cd /src && \  
python setup.py install  
  
EXPOSE 5000

