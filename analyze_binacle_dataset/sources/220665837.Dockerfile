FROM widukind/docker-base

ADD . /code/

RUN pip install -U -r requirements.txt \
	&& pip install -U -r requirements-tests.txt \
    && pip install --no-deps -e .
