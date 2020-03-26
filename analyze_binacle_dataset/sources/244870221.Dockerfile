FROM python:2.7.8

ENV PYTHONUNBUFFERED=1

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y \
    libxml2-dev libxslt-dev python-dev  \
    libyaml-dev \
    graphviz


COPY tests_requirements.txt /tests_requirements.txt

# Install pyenv for tox
RUN git clone https://github.com/yyuu/pyenv.git ~/.pyenv
ENV HOME /root
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
RUN echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
RUN echo 'eval "$(pyenv init -)"' >> ~/.bash_profile

RUN exec $SHELL

RUN pyenv install 2.7 && \
    pyenv install 3.2  && \
    pyenv install 3.3.0 && \
    pyenv install 3.4.0 && \
    pyenv install 3.5.0 && \
    pyenv install 3.6.0 && \
    pyenv install 3.7-dev && \
    pyenv install pypy-4.0.1

# RUN pyenv local 2.7 3.2 3.3.0 3.4.0 3.5.0 3.6.0 3.7-dev pypy-4.0.1

RUN pip install -U pip setuptools wheel==0.30.0a0 pyparsing==2.1.10 twine
RUN pip install -U plop gprof2dot ipython

RUN pip install -U -r /tests_requirements.txt


ENTRYPOINT ["/bin/bash", "-c"]
