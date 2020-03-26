FROM python:3.6  
ENV PYTHON_VERSION 3.6  
ENV VERSION 0.1  
WORKDIR /usr/src/app  
  
VOLUME /usr/src/app  
  
COPY requirements.txt ./  
RUN pip install --no-cache-dir -r requirements.txt  
  
#The Python start script file  
ENV SCRIPT_PATH main.py  
  
CMD python ${SCRIPT_PATH}

