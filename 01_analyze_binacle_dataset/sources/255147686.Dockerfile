#
# Docker image for ipython notebook and various
#  python courses
#
FROM python:2.7

RUN apt-get -y update && apt-get -y install gcc make python-dev python-pip 
RUN apt-get -y update && apt-get -y install build-essential libblas-dev liblapack-dev gfortran  libfreetype6-dev libpng-dev
RUN apt-get -y update && apt-get -y install tree

# Install MySQL
RUN echo mysql-server mysql-server/root_password password pass | debconf-set-selections;\
    echo mysql-server mysql-server/root_password_again password pass | debconf-set-selections;\
    apt-get -y update && apt-get install -y mysql-server mysql-client libmysqlclient-dev

# Install mongodb
RUN apt-get -y update && apt-get install -y mongodb
RUN apt-get -y clean

RUN pip install -U pip

COPY requirements.txt /requirements.txt
COPY advanced /curso-python/advanced
COPY basic /curso-python/basic
COPY sysadmin /curso-python/sysadmin
COPY best-practices /curso-python/best-practices

# install requirements
RUN pip install -r /requirements.txt

EXPOSE 8888

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["./docker-entrypoint.sh"]
