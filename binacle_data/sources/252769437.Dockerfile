FROM python:3  
MAINTAINER Ando Roots <ando@sqroot.eu>  
  
RUN pip install datadog requests  
  
COPY sportid-monitor.py /opt/  
  
CMD [ "python", "./opt/sportid-monitor.py" ]

