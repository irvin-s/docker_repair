FROM continuumio/miniconda3
COPY . /data/scrapers
RUN apt-get update -y
RUN apt-get install -y locales locales-all
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
RUN apt-get install -qy build-essential
RUN apt-get install -qy default-libmysqlclient-dev python-dev
RUN pip install -r /data/scrapers/requirements.txt
WORKDIR /data/scrapers/scrapers