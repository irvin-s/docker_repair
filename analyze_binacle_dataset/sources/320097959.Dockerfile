FROM python:3

RUN mkdir /app
ADD . /app/

RUN pip install -r /app/requirements.txt

ENTRYPOINT ["python", "/app/main.py", "--host=0.0.0.0"]

EXPOSE 5000
