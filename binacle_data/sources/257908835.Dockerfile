FROM python:3.6
ENV PYTHONUNBUFFERED 1

RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64 && chmod +x /usr/local/bin/dumb-init

RUN apt-get update && apt-get install -y libav-tools --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN mkdir /code
WORKDIR /code
ADD requirements.txt /code/
RUN pip install --no-cache-dir -r requirements.txt

ADD . /code/

RUN python manage.py collectstatic --no-input

