FROM ubuntu:latest
MAINTAINER Beau Cronin "beau.cronin@gmail.com"
RUN apt-get update -y
RUN apt-get install -y python-pip python-dev build-essential
COPY web /app
WORKDIR /app
RUN pip install -r requirements.txt
ENTRYPOINT ["python"]
CMD ["app.py"]
# CMD ["/bin/sh", "-c", "python app.py > server.log 2>&1"]

EXPOSE 5000