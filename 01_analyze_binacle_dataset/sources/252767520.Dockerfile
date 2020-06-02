FROM python:alpine  
  
RUN pip install mkdocs  
  
COPY . /app  
WORKDIR /app  
  
RUN mkdocs build --clean  
  
EXPOSE 8010  
ENTRYPOINT ["mkdocs", "serve", "--dev-addr=0.0.0.0:8010"]

