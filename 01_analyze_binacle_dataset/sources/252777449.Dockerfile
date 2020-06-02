FROM python:3.6  
RUN mkdir -p /opt/lc  
  
WORKDIR /opt/lc  
  
COPY requirements.txt /opt/lc  
RUN pip install --no-cache-dir -r requirements.txt  
  
COPY . /opt/lc  
  
EXPOSE 12589  
ENTRYPOINT ["/opt/lc/start.sh"]

