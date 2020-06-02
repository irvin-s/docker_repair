FROM python:2-slim  
  
# cross-compile-start  
RUN apt-get update && apt-get install -y --no-install-recommends \  
g++ \  
libmysqlclient-dev \  
&& rm -rf /var/lib/apt/lists/*  
  
WORKDIR /usr/src/app  
  
COPY requirements.txt ./  
RUN pip install --no-cache-dir -r requirements.txt  
  
COPY . .  
  
EXPOSE 8000  
# cross-compile-end  
CMD ["celery","-A", "main", "worker", "--loglevel=debug"]  

