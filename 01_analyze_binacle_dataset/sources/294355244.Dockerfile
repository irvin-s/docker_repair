FROM jjanzic/docker-python3-opencv

RUN mkdir /code
ADD . /code/
WORKDIR /code
RUN pip3 install -e .
RUN pip3 freeze
RUN python3 setup.py install

WORKDIR /code/cli
ENTRYPOINT ["python3", "predict_main.py"]
