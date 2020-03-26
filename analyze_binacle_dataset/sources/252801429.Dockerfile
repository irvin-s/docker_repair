FROM ubuntu  
RUN apt-get update && apt-get install -q -y python-pip  
RUN pip install --upgrade googleads  
ADD download.py /download.py

