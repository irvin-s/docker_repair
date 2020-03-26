FROM continuumio/miniconda
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
ADD environment.yml /code/
RUN conda env create -f environment.yml
ADD . /code/
