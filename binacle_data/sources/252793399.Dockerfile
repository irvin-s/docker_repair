FROM python:2.7  
COPY requirements.txt /  
RUN pip install -r /requirements.txt  
RUN rm -vf /requirements.txt  
  
COPY code.py /  
  
CMD [ "python", "/code.py" ]  

