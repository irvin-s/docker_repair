FROM python:3.6.2

ADD . /src
WORKDIR /src

RUN pip install -r requirements.txt
RUN python setup.py install

CMD ["pserve", "edwiges.ini"]
