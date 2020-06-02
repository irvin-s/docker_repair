FROM tensorflow/tensorflow:latest-py3

ARG app_dir=deployment/aist-tensorflow

USER root

COPY $app_dir/requirements.txt /app/

WORKDIR /app

RUN pip install -r requirements.txt

RUN apt-get -y update
RUN apt-get -y install supervisor

ADD $app_dir/supervisord.conf /etc/

ENV PATH /bin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/sbin

COPY common/dist/aist_common-0.0.1-py3-none-any.whl /app

RUN pip install aist_common-0.0.1-py3-none-any.whl

COPY . /app