FROM jupyter/base-notebook

USER $NB_USER

WORKDIR /usr/$NB_USER
ADD . /usr/$NB_USER/
