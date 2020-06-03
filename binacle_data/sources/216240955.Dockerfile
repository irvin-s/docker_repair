FROM python:3.5.1

WORKDIR /project
ADD requirements.txt /project/requirements.txt
RUN pip3 install -r /project/requirements.txt

ADD . /project

CMD python3 -u bot.py
