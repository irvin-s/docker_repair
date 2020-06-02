FROM python:3.6

RUN pip3 install --no-cache-dir \
        datascience \
        nbconvert \
        jupyter_client \
        ipykernel \
        matplotlib \
        pandas \
        ipywidgets \
        scipy

RUN pip3 install --no-cache-dir okgrade==0.4.3

COPY . /srv/repo

WORKDIR /srv/repo
