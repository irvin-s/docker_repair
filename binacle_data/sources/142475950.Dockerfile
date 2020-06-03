FROM python:3.6

ENV PYTHONPATH=/external/lib

WORKDIR /app

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

COPY / /app

CMD [ "python", "app.py" ]
