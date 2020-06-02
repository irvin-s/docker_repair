FROM python:3.5
ENV PYTHONUNBUFFERED 1

# update packages and install apt-reqs
RUN apt-get update && apt-get install -y --no-install-recommends \
    ## django.contrib.gis
    binutils libproj-dev gdal-bin

RUN mkdir /code
WORKDIR /code
ADD requirements.txt /code/
# get newest pip wheel and setuptools
RUN curl https://bootstrap.pypa.io/get-pip.py | python
RUN pip install -r requirements.txt
