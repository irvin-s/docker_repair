FROM python:3.6-jessie
RUN mkdir /code
ADD requirements.txt /code
WORKDIR code
RUN pip install -r requirements.txt && \
    apt-get update && apt-get install -y curl python-software-properties && \
    curl -sL https://deb.nodesource.com/setup_9.x | bash - && \
    apt-get install -y nodejs
ADD . /code
RUN cd web_server/frontend && npm install && npm run build && \
    cd ../ && python3 manage.py makemigrations && python3 manage.py migrate && \
    python3 manage.py collectstatic
CMD ["python3", "webserver/manage.py runserver 0.0.0.0:8000"]
