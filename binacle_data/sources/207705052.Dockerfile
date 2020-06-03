FROM python:3.6

RUN pip install --upgrade pip
RUN pip install --upgrade pip-tools
RUN pip install --upgrade virtualenv

VOLUME /app
WORKDIR /app

STOPSIGNAL SIGTERM

RUN echo "" >> ~/.bashrc && \
    echo 'source ~/.bashrc_mdstudio' >> ~/.bashrc

ENV PYENV_SHELL=/bin/bash

ADD .bashrc_mdstudio /root/.bashrc_mdstudio

CMD "bash"
