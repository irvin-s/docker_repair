FROM python:2.7-alpine  
  
RUN apk update && \  
apk upgrade && \  
apk add openssh-client && \  
rm -rf /var/cache/apk/*  
  
RUN pip install pexpect  
  
EXPOSE 9090  
ADD server.py /app/server.py  
  
CMD ["python", "/app/server.py"]

