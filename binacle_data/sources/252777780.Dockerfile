FROM python:3  
LABEL maintainer="Alexander Nwala <anwala@cs.odu.edu>"  
  
WORKDIR /src  
COPY requirements.txt .  
RUN pip install --no-cache-dir -r requirements.txt  
COPY . .  
  
CMD ["./app.py"]

