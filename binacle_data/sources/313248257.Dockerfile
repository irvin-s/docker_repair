FROM python:3.6

ENV LC_ALL C.UTF-8
ENV PYTHONUNBUFFERED 1
RUN apt-get update && apt-get install --no-install-recommends -y \
  vim \
  curl \
  && pip install --upgrade pip

RUN mkdir /project
WORKDIR /project
ADD requirements /project/requirements
RUN python -m pip install -r requirements/requirements.txt
RUN python -m pip install -r requirements/requirements-dev.txt
ADD . /project/
RUN python -m pip install -e .