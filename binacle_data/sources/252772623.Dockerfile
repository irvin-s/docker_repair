FROM python:2.7-onbuild  
EXPOSE 5000  
ENV BUCKET your-s3-bucket  
  
CMD ./s3webfront.py --port 5000 --bucket $BUCKET  

