FROM python:3.6-alpine  
  
WORKDIR /app  
COPY ./ ./  
RUN pip install -r requirements.txt  
  
ENV PYTHONIOENCODING = utf-8  
EXPOSE 8000  
CMD [ "python", "./labelprinterServe.py" ]  

