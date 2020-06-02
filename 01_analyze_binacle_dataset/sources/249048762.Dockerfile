FROM python:latest

MAINTAINER <mohamed@farghal.com>

ENV CL_MASTER_HOST='127.0.0.1:5555'

RUN pip3 install numpy dill pandas
RUN git clone https://github.com/medo/Pandas-Farm.git

WORKDIR Pandas-Farm

CMD python3 start_slave.py
