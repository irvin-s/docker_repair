FROM ubuntu:trusty

RUN apt-get update
RUN apt-get dist-upgrade -y
# These are dependencies that are installed on Travis but not in the base Docker image
RUN apt-get install -y python-pip ninja-build cmake git-core wget
RUN apt-get install -y unixodbc unixodbc-dev
RUN apt-get install -y libboost-all-dev
RUN apt-get install -y mysql-server-5.6 mysql-client-core-5.6 mysql-client-5.6 libmyodbc
RUN apt-get install -y postgresql odbc-postgresql=1:09.02.0100-2ubuntu1

RUN pip install -U pip setuptools setuptools_scm
RUN pip install -U numpy==1.10.4 pyarrow==0.8.0 pybind11==2.2.0 pytest pytest-cov mock six pandas==0.20.0
