FROM python:3.6

EXPOSE 5000

ENV APP /app
RUN mkdir $APP
WORKDIR $APP 

COPY requirements.txt .
RUN pip install -r requirements.txt
RUN (echo "deb http://deb.debian.org/debian stretch main non-free" > /etc/apt/sources.list) && \
    (echo "deb http://security.debian.org/debian-security stretch/updates main" >> /etc/apt/sources.list) && \
    (echo "deb http://deb.debian.org/debian stretch-updates main" >> /etc/apt/sources.list) && \
    (apt-get update && apt-get dist-upgrade && apt-get install unrar)

COPY . .
COPY .doujinshi.docker.json ./.doujinshi.json
CMD python -u doujinshi-db.py
