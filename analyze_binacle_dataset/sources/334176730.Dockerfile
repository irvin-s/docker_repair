FROM blacktop/yara
WORKDIR /app
COPY requirements.txt /app/requirements.txt
RUN apk add --update py-pip
RUN pip install -r /app/requirements.txt
COPY yara2es.py /app/yara2es.py
ENTRYPOINT ["python", "/app/yara2es.py"]