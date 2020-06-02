FROM tensorflow/tensorflow:latest-py3
LABEL maintainer Garrett Hoffman <garrett@stocktwits.com>

RUN mkdir api/
COPY . api/

WORKDIR /api/
RUN pip install -r requirements.txt

CMD ["flask", "run", "-h", "0.0.0.0", "-p", "5000"]