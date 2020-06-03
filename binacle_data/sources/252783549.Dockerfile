FROM python:3.6-slim  
RUN pip install 'boto3==1.7.4'  
COPY fetcher.py /usr/local/bin/fetcher.py  
RUN chmod a+x /usr/local/bin/fetcher.py  
RUN ln -s /usr/local/bin/fetcher.py /usr/local/bin/fetcher  
ENTRYPOINT ["/usr/local/bin/fetcher"]  

