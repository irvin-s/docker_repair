FROM jupyter/nature-base

EXPOSE 8888

RUN useradd -m -s /bin/bash jovyan
ADD Nature.ipynb /home/jovyan/
ADD images /home/jovyan/images/

ADD ga/ /srv/ga/

RUN chown jovyan:jovyan /home/jovyan -R

USER jovyan
ENV HOME /home/jovyan
ENV SHELL /bin/bash
ENV USER jovyan

WORKDIR /home/jovyan/

# Create a profile so we can add our own settings.
RUN ipython3 profile create

USER root
ADD ipython_notebook_config.py /home/jovyan/.ipython/profile_default/
RUN chown -R jovyan:jovyan /home/jovyan

USER jovyan
RUN find . -name '*.ipynb' -exec ipython trust {} \;

CMD ipython3 notebook
