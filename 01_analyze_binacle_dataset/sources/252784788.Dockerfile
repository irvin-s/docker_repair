FROM python:3.6-alpine  
  
RUN apk --no-cache add tini curl \  
&& pip install --no-cache-dir \  
"Flask~=0.12.2" \  
"requests~=2.17.3" \  
"minio~=2.2.2"  
  
WORKDIR /usr/src/app  
COPY . /usr/src/app  
  
CMD ["/sbin/tini", "--", "python", "scraper.py"]  
EXPOSE 5000  

