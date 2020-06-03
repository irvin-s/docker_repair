FROM gliderlabs/alpine:3.1  
MAINTAINER Allan Costa "allan@cloudwalk.io"  
RUN apk --update add python py-pip && rm -rf /var/cache/apk/*  
  
WORKDIR /src/fleet-browser  
  
# Copy and install requirements  
COPY requirements.txt requirements.txt  
RUN pip install -r requirements.txt  
  
# Copy other files  
COPY . .  
  
EXPOSE 5000  
ENTRYPOINT ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]  

