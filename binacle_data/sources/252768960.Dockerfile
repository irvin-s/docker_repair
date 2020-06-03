FROM python:3.5-alpine  
  
RUN apk add --no-cache --virtual .tmp-packeges build-base \  
&& pip install dumb-init==1.2.1\  
&& apk del .tmp-packeges  
  
RUN mkdir /app  
COPY requirements.txt /app/  
COPY k8s-events-to-slack-streamer.py /app/  
RUN pip install -r /app/requirements.txt  
  
WORKDIR /app  
ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]  
CMD ["python3", "./k8s-events-to-slack-streamer.py"]  

