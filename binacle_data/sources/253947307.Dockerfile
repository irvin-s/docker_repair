ARG branch=unknown

FROM registry.spin.nersc.gov/das/jupyter-base.${branch}:latest
LABEL maintainer="Rollin Thomas <rcthomas@lbl.gov>"

# Python 3 Anaconda and additional packages

RUN \
    /opt/anaconda3/bin/conda update --yes conda &&  \
    /opt/anaconda3/bin/conda install --yes          \
        ipykernel                                   \
        ipywidgets                                  \
        notebook                                &&  \
    /opt/anaconda3/bin/ipython kernel install   &&  \
    /opt/anaconda3/bin/conda clean --yes --all

# Typical extension

RUN \
    /opt/anaconda3/bin/jupyter nbextension enable --sys-prefix --py widgetsnbextension

ADD docker-entrypoint.sh jupyterhub_config.py /srv/

# Some dummy users

RUN \
    adduser -q --gecos "" --disabled-password torgo     && \
    echo torgo:the-master-would-not-approve | chpasswd

RUN \
    adduser -q --gecos "" --disabled-password master    && \
    echo master:you-have-failed-us-torgo | chpasswd

WORKDIR /srv
RUN chmod +x docker-entrypoint.sh
CMD ["jupyterhub", "--debug"]
ENTRYPOINT ["./docker-entrypoint.sh"]
