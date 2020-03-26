FROM python:2  
ADD ml.py /  
COPY recepts2.csv ./  
RUN pip install numpy  
RUN pip install pandas  
RUN pip install Flask  
RUN pip install fuzzywuzzy  
RUN pip install sklearn  
RUN pip install scipy  
CMD [ "python", "./ml.py" ]  
  

