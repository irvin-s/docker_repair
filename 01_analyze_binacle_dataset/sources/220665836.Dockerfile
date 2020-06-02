FROM widukind/docker-base

ADD . /code/

WORKDIR /code/

RUN pip install -r requirements.txt \
    && pip install --no-deps -e .

