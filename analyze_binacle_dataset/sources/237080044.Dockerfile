FROM python:3.5.2

WORKDIR /project

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

CMD python server.py