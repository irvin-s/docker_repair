FROM python:3.5.1-onbuild  
RUN mkdir app  
ADD . /app  
WORKDIR /app  
  
ARG APP_CONFIG_FILE='./app/config/production.py'  
COPY requirements.txt /app  
  
EXPOSE 9000  
ENTRYPOINT ["python", "main.py"]

