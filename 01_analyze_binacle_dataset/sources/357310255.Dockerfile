FROM debian:latest
MAINTAINER Nicola Kabar nicola@docker.com
RUN apt-get update -y && \
    apt-get install -y python-pip \
    python-dev
ADD . /app
WORKDIR /app
RUN pip install -r requirements.txt
EXPOSE 5000
ENTRYPOINT ["python"]
CMD ["webapp.py"]

