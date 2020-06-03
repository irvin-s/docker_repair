#  
# Dockerfile for py-kms  
#  
FROM python:2-alpine  
MAINTAINER Samuel X. S. Tseng <i@xlibc.me>  
  
ADD ./kms /kms  
  
EXPOSE 1688  
CMD ["python", "/kms/server.py"]  

