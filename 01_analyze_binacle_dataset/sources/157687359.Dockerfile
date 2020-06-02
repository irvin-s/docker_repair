FROM python:2.7
ADD web /var/www
WORKDIR /var/www
RUN pip install -r requirements.txt