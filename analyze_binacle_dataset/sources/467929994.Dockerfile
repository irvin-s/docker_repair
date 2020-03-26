FROM python:3.6-stretch

WORKDIR /var/www/testex

COPY requirements.txt ./requirements.txt
RUN pip3 install -r requirements.txt

COPY . /var/www/testex

EXPOSE 8008

CMD gunicorn -b 0.0.0.0:8008 -w 2 "app:create_app('prod')" --access-logfile '-'
