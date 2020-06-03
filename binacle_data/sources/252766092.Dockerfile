FROM python:3.6-alpine  
  
ADD fwatchdog /usr/bin/  
  
RUN pip install docker && \  
chmod +x /usr/bin/fwatchdog  
  
ADD container_run.py container_run.py  
ENV fprocess="python3 container_run.py"  
CMD ["fwatchdog"]  
  

