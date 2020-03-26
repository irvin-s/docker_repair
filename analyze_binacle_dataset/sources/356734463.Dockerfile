# Python3 ipython and notebook server

# Runs with:
# $ docker run -it -p 80:8888 pdonorio/py3note ipython notebook --ip 0.0.0.0

# Stack with no hub:
# $ cd python/py3base; docker build -t pdonorio/py3kbase .
# $ cd ../py3notebook; docker build -t pdonorio/jupy3k .

FROM pdonorio/py3kbase
MAINTAINER "Paolo D'Onorio De Meo <p.donoriodemeo@gmail.com>"

# More dependencies - notebooks are very heavy in those
RUN apt-get install -y nodejs nodejs-legacy npm

# Define an ipthon kernel
VOLUME /srv
WORKDIR /srv
RUN git clone --depth 1 https://github.com/ipython/ipykernel \
    && cd ipykernel && pip3 install --pre -e . && cd .. && rm -rf ipykernel

# Install development jupyter project
RUN git clone https://github.com/jupyter/notebook.git \
    && chmod -R +rX notebook && cd notebook \
    && pip3 install --upgrade -e .[test] \
    && python3 setup.py install \
    && cd .. && rm -rf notebook

# # Install latest stable notebook package
# RUN pip3 install notebook

# Start referring to a data directory
VOLUME /data
WORKDIR /data
