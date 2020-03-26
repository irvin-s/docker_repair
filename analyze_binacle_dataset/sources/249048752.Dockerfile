FROM python:latest

MAINTAINER <mohamed@farghal.com>

ENV PORT=5555

RUN pip3 install numpy dill pandas
RUN git clone https://github.com/medo/Pandas-Farm.git

WORKDIR Pandas-Farm

EXPOSE 5555

CMD python3 start_master.py
