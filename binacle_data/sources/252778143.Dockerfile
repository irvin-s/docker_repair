FROM jfloff/alpine-python  
MAINTAINER Applied Information Sciences <matt.anderson@appliedis.com>  
  
ENV BASE_DIR=./app  
  
RUN mkdir -p $BASE_DIR  
WORKDIR $BASE_DIR  
ADD ./ ./  
  
RUN pip install -r requirements/common.txt -r requirements/prod.txt && \  
touch .env  
  
EXPOSE 8080  
CMD ["./main.py", "--host=0.0.0.0"]  

