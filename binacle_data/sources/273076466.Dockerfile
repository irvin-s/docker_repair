FROM python:3.5

RUN mkdir /src
WORKDIR /src

COPY requirements /src/requirements/

RUN pip install \
    -r requirements/docs.txt \
    -r requirements/install.txt \
    -r requirements/publish.txt \
    -r requirements/test.txt

COPY . /src
RUN pip install .