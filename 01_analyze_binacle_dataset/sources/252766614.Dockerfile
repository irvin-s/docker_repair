FROM python:alpine  
MAINTAINER Aaron Jones <akjones@mykolab.com>  
  
RUN apk add --update \  
python \  
python-dev \  
py-pip \  
build-base \  
&& rm -rf /var/cache/apk/*  
  
RUN echo "apiKey = "changeme"" > apiConfig.py  
  
EXPOSE 5000  
COPY . /app  
WORKDIR /app  
RUN pip install -r /app/requirements.txt  
ENTRYPOINT ["python"]  
CMD ["app.py"]  

