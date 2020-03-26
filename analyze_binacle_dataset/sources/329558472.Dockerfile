FROM python:3.6
RUN apt-get update -y
RUN apt-get install -y python3-pip
COPY /core/ /app/core/
COPY /requirements.txt /app/core/requirements.txt
COPY /shared/ /app/shared/
COPY /core/config/docker.conf /app/core/core.conf
WORKDIR /app/core/
RUN pip3 install -r requirements.txt
CMD ["python3.6", "api.py"]

