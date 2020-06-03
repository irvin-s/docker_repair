FROM python:3.7

ADD code /

RUN pip install -r /requirements.txt
RUN chmod +x /query_runner.py

CMD ["python3", "/query_runner.py"]
