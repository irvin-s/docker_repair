FROM jupyter/jupyterhub:latest

WORKDIR /srv/

RUN git clone --depth 1 https://github.com/jupyter/dockerspawner.git
WORKDIR /srv/dockerspawner
RUN pip3 install -r requirements.txt && python3 setup.py install

# Fixup jupyterhub by hand for the moment, incredibly evil
ADD templates/login.html /usr/local/share/jupyter/hub/templates/login.html

WORKDIR /srv/
ADD . /srv/carina-jupyterhub
WORKDIR /srv/carina-jupyterhub
RUN pip3 install .
