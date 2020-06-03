FROM continuumio/anaconda

MAINTAINER Magrathea Labs <contact@magrathealabs.com>

ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV PYTHONIOENCODING UTF-8

RUN conda update --all && \
    conda install --yes \
        jupyter \
        ipywidgets \
        pandas \
        matplotlib \
        seaborn \
        numpy \
        scipy \
        scikit-learn \
        scikit-image

RUN pip install widgetsnbextension && \
    jupyter nbextension enable --py widgetsnbextension

ADD configs/ /tmp/
RUN mkdir -p -m 700 /root/.jupyter/ && \
    cp /tmp/jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py

VOLUME /notebooks
WORKDIR /notebooks
EXPOSE 8888

ENV TINI_VERSION v0.9.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

CMD ["jupyter", "notebook", "--no-browser", "--allow-root"]

