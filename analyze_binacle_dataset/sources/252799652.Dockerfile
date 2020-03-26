#scanner image  
FROM python:alpine  
  
RUN mkdir /code  
  
WORKDIR /code  
  
COPY pyFinder/requirements.txt /code/  
RUN pip install --upgrade pip  
RUN pip install -r requirements.txt  
  
# ADD . /code/  
# install pyfinder module in the container  
# ADD setup.py /code  
# RUN python setup.py install  
COPY pyFinder/ /code  
  
ENTRYPOINT ["python","/code/entryScanner.py"]  
CMD ["--help"]  

