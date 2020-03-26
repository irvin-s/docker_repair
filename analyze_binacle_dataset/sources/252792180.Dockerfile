FROM python:3-alpine  
  
WORKDIR /app/  
COPY requirements.txt /app/  
RUN pip install -r requirements.txt  
  
COPY . /app/  
  
STOPSIGNAL SIGKILL  
CMD ["python3", "discord_cron.py"]  
ENV PYTHONUNBUFFERED=1  
LABEL name=discord-cron version=dev \  
maintainer="Simone Esposito <chaufnet@gmail.com>"  

