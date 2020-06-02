FROM ubuntu:18.04

# This isn't done but is probably enough to get the tests running on other machines

run echo "travis_fold:start:Dapt\033[33;1mservice Dockerfile apt\033[0m" && \
    apt-get -qq update && apt-get install -qq clang python3 python3-dev python3-openssl xinetd firefox build-essential python3-virtualenv python3-setuptools wget sqlite3 gunicorn && \
    echo "\ntravis_fold:end:Dapt\r"

# Install geckodriver
RUN wget https://github.com/mozilla/geckodriver/releases/download/v0.24.0/geckodriver-v0.24.0-linux64.tar.gz && tar xvf geckodriver-v0.24.0-linux64.tar.gz && mv geckodriver /usr/local/bin

# Install phantomjs
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 -O phantomjs.tar.bz2 && \
  tar xvf phantomjs.tar.bz2 && \
  cp phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/bin/ && \
  chmod ugo+x /usr/bin/phantomjs && \
  rm -rf phantomjs-2.1.1-linux-x86_64 phantomjs.tar.bz2

# Extra dependencies for tests
RUN apt-get -qq update && apt-get install -qq curl


RUN mkdir /tests

# Set up virtualenv and install dependencies
COPY requirements.txt /tests
RUN python3 -m virtualenv --python=/usr/bin/python3 /tests/venv
RUN . /tests/venv/bin/activate && pip install -r /tests/requirements.txt

COPY *.sh /
COPY *.py /

RUN chmod +x *.sh *.py
