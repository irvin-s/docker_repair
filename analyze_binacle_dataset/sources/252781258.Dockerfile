FROM python:2.7  
MAINTAINER cowpanda<ynw506@gmail.com>  
COPY requirements.txt ./  
RUN pip install --no-cache-dir -r requirements.txt  
RUN pip --no-cache-dir install turtle --trusted-host mirrors.aliyun.com  
  
COPY start.app /start.app  
RUN chmod 755 /start.app  
VOLUME ["/app"]  
WORKDIR /app  
  
CMD ["/start.app"]  
  

