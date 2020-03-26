FROM python:3.6.2  
ADD . .  
ENV DOCKER yes  
RUN pip install -r requirements.txt  
CMD python -u run.py  

