FROM python:3-slim  
RUN pip install ccxt \  
pybitflyer \  
pytz \  
requests  
  
COPY ./trade_bf.py /  
ENTRYPOINT ["/trade_bf.py"]  

