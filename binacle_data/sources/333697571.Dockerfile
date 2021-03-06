FROM python:3.6.1 
COPY . /app 
WORKDIR /app 
RUN pip install -r requirements.txt 
ENTRYPOINT ["nameko"] 
CMD ["run", "--config",  "config.yaml", "services"] 
EXPOSE 8000 