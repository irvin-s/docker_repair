FROM alpine:3.4
MAINTAINER "Paolo D'Onorio De Meo <p.donoriodemeo@gmail.it>"

# RUN apk add --no-cache python3 && \
#     python3 -m ensurepip && \
#     rm -r /usr/lib/python*/ensurepip && \
#     pip3 --no-cache-dir install --upgrade pip setuptools && \
#     rm -r /root/.cache
# # RUN apk update && apk upgrade \
# #     && apk add \
# #     py-setuptools

RUN apk update && apk upgrade

RUN apk --update --no-cache \
    --repository http://dl-4.alpinelinux.org/alpine/edge/community add \
    bash git curl ca-certificates \
    bzip2 unzip sudo \
    # libstdc++ glib libxext libxrender \
    tini

RUN curl -L "https://github.com/andyshinn/alpine-pkg-glibc/releases/download/2.23-r3/glibc-2.23-r3.apk" -o /tmp/glibc.apk \
    && curl -L "https://github.com/andyshinn/alpine-pkg-glibc/releases/download/2.23-r3/glibc-bin-2.23-r3.apk" -o /tmp/glibc-bin.apk \
    && curl -L "https://github.com/andyshinn/alpine-pkg-glibc/releases/download/2.23-r3/glibc-i18n-2.23-r3.apk" -o /tmp/glibc-i18n.apk \
    && apk add --allow-untrusted /tmp/glibc*.apk \
    && /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib \
    && /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 \
    && rm -rf /tmp/glibc*apk /var/cache/apk/*

RUN apk add rethinkdb \
    --no-cache --repository http://dl-4.alpinelinux.org/alpine/edge/testing

# Configure environment
ENV CONDA_DIR=/opt/conda CONDA_VER=4.1.11
ENV PATH=$CONDA_DIR/bin:$PATH SHELL=/bin/bash LANG=C.UTF-8
ENV CONDA_REPO="https://repo.continuum.io/miniconda"

# Install conda
RUN mkdir -p $CONDA_DIR && \
    echo export PATH=$CONDA_DIR/bin:'$PATH' > /etc/profile.d/conda.sh && \
    curl $CONDA_REPO/Miniconda3-${CONDA_VER}-Linux-x86_64.sh  -o mconda.sh && \
    /bin/bash mconda.sh -f -b -p $CONDA_DIR && \
    rm mconda.sh && \
    $CONDA_DIR/bin/conda install --yes conda==${CONDA_VER}

# Install all OS dependencies for fully functional notebook server

# Configure environment
ENV CONDA_DIR=/opt/conda \
  PATH=$CONDA_DIR/bin:$PATH \
  SHELL=/bin/bash \
  NB_USER=jovyan \
  NB_UID=1000

# Install Jupyter notebook

# Create jovyan user with UID=1000 and in the 'users' group
# Grant ownership over the conda dir and home dir, but stick the group as root.
RUN adduser -s /bin/bash -u $NB_UID -D $NB_USER && \
    mkdir /home/$NB_USER/work \
    && mkdir /home/$NB_USER/.jupyter \
    && mkdir /home/$NB_USER/.local \
    && mkdir -p $CONDA_DIR \
    && chown -R $NB_USER:users $CONDA_DIR \
    && chown -R $NB_USER:users /home/$NB_USER

USER $NB_USER

RUN conda install --yes \
    'notebook=4.2*' terminado pip ipywidgets jupyter \
    'pandas=0.18*' \
    # 'numexpr=2.5*' \
    'matplotlib=1.5*' \
    'scipy=0.17*' \
    'seaborn=0.7*' \
    # 'scikit-learn=0.17*' \
    # 'scikit-image=0.11*' \
    # 'sympy=1.0*' \
    'cython=0.23*' \
    # 'patsy=0.4*' \
    # 'statsmodels=0.6*' \
    # 'cloudpickle=0.1*' \
    # 'dill=0.2*' \
    'numba=0.23*' \
    'bokeh=0.11*' \
    # 'sqlalchemy=1.0*' \
    # 'h5py=2.5*' && \
    && conda remove --quiet --yes --force qt pyqt \
    && conda clean -tipsy

# # Activate ipywidgets extension in the environment that runs the notebook server
# RUN jupyter nbextension enable --py widgetsnbextension --sys-prefix

RUN pip --no-cache-dir install --upgrade \
    pip rethinkdb

# Configure container startup
EXPOSE 8888
WORKDIR /home/$NB_USER/work
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["start-notebook.sh"]

USER root

# Add local files as late as possible to avoid cache busting
COPY start-notebook.sh /usr/local/bin/
COPY start-singleuser.sh /usr/local/bin/
COPY jupyter_notebook_config.py /home/$NB_USER/.jupyter/
RUN chown -R $NB_USER:users /home/$NB_USER/.jupyter

USER $NB_USER
