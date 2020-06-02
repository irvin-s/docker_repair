FROM python:3.5-alpine  
  
MAINTAINER davojan  
  
RUN pip install --upgrade pip  
  
RUN pip install plumbum  
  
WORKDIR /root/  
  
ONBUILD COPY *.py ./  
  
ONBUILD RUN chmod a+x *.py && \  
python -OO -m compileall -l ./  
  
ENTRYPOINT ["python"]  

