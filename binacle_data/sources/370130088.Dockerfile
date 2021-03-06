FROM python:3.7

# install dependenices
RUN apt-get update && apt-get upgrade -y && \
  apt-get install sqlite3 && apt-get install -y vim
# sets up nodejs to install npm
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash
RUN apt-get install nodejs

WORKDIR /var/www/tab
COPY requirements.txt ./
COPY package.json ./
COPY package-lock.json ./
RUN pip install -r requirements.txt

# setup django
COPY manage.py ./
COPY setup.py ./
COPY ./mittab ./mittab
COPY ./assets ./assets
