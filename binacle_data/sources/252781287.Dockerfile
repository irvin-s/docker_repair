FROM library/python:3.5-slim  
WORKDIR /  
ADD ./adapter.py /adapter.py  
  
RUN pip install click rqopen_client requests  
CMD "python /adapter.py"  

