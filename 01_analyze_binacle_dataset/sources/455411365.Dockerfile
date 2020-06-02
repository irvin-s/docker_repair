FROM python:3.5
RUN mkdir /app
WORKDIR /app
COPY . /app
RUN pip install -r requirements.txt