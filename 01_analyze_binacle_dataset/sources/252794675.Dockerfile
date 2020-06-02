FROM python:3.6  
RUN apt-get update -y && apt-get install -y \  
libopus-dev \  
libav-tools \  
tesseract-ocr  
  
RUN curl -L https://nodejs.org/dist/v8.9.4/node-v8.9.4-linux-x64.tar.xz \  
| tar xJ --strip-components=1 -C /usr/ &&\  
ACCEPT_HIGHCHARTS_LICENSE=YES npm i -g highcharts-export-server --unsafe-perm  
  
ADD . /app  
WORKDIR /app  
  
RUN pip install --upgrade pip  
COPY requirements.txt ./  
RUN pip install \  
\--no-cache-dir \  
-r requirements.txt  
  
CMD [ \  
"python3", "src/main.py", \  
"--plugin-path", "plugins", \  
"--config-path", "config.yaml" \  
]  

