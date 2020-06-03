FROM python:3-alpine  
  
ENV PYTHONUNBUFFERED 1  
RUN mkdir /app  
WORKDIR /app  
  
COPY requirements.txt /app/  
RUN pip install -r requirements.txt  
  
COPY wsgi.py /app/  
RUN python -m compileall .  
  
EXPOSE 8000  
CMD ["gunicorn", "wsgi", "-b", "0.0.0.0:8000", "--log-file", "-"]  

