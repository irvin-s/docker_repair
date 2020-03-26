FROM ubuntu:14.04
ADD . /app
WORKDIR /app
RUN apt-get update && apt-get install -y python-pip
RUN pip install -r requirements.txt
CMD ["python", "app.py"]
