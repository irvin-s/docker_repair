FROM ubuntu:xenial
RUN apt-get update -y
RUN apt-get install -y python-pip
COPY requirements.txt /
RUN pip install -r /requirements.txt
COPY . /app
WORKDIR /app
ENTRYPOINT ["python", "app.py"]
EXPOSE 5000
