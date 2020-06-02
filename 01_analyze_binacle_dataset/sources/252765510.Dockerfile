FROM python:3.5  
COPY ["census_similarity", "/app/src/census_similarity/"]  
COPY ["setup.py", "requirements.txt", "/app/src/"]  
  
WORKDIR /app/src/  
RUN pip install --no-cache-dir -r requirements.txt  
  
ENV PYTHONUNBUFFERED="1"  

