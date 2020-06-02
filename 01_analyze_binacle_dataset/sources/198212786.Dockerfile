FROM python:2.7
MAINTAINER Ryan Draga <ryan.draga@tuxotaku.com>
LABEL version="1.0"
ENV PYTHONDONTWRITEBYTECODE 1
ADD . /app
WORKDIR /app
EXPOSE 8000
RUN pip install -r requirements.txt --no-cache-dir --disable-pip-version-check