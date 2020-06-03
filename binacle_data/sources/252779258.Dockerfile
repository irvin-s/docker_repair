FROM python:2.7.13  
MAINTAINER c036  
  
RUN git clone https://github.com/abrenaut/posio.git  
WORKDIR /posio  
  
RUN pip install Flask  
RUN python setup.py install && export POSIO_SETTINGS=/config.py  
  
EXPOSE 5000  
CMD ["python", "run.py"]  

