############################################
## Scientific course @CINECA

FROM alpine:edge
MAINTAINER "Paolo D'Onorio De Meo <p.donoriodemeo@cineca.it>"

############################################
# Base packages
ENV SHELL /bin/bash
ENV GLIBC_VERSION 2.23-r3
ENV GLIBC_REPO https://github.com/andyshinn/alpine-pkg-glibc/releases/download/$GLIBC_VERSION

RUN apk --update add \
    --repository http://dl-4.alpinelinux.org/alpine/edge/testing \
    rethinkdb \
    && apk --update add \
        bash wget curl ca-certificates bzip2 unzip \
        sudo musl-dev git vim \
        gcc libstdc++ glib libxext libxrender tini \
    && curl -L "$GLIBC_REPO/glibc-${GLIBC_VERSION}.apk" -o /tmp/glibc.apk \
    && curl -L "$GLIBC_REPO/glibc-bin-${GLIBC_VERSION}.apk" -o /tmp/glibc-bin.apk \
    && curl -L "$GLIBC_REPO/glibc-i18n-${GLIBC_VERSION}.apk" -o /tmp/glibc-i18n.apk \
    && apk add --allow-untrusted /tmp/glibc*.apk \
    && /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib \
    && /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 \
    && rm -rf /tmp/glibc*apk && rm -rf /var/cache/apk/*

############################################
## CONDA

ENV CONDA_DIR /opt/conda
RUN mkdir -p $CONDA_DIR
ENV PATH $CONDA_DIR/bin:$PATH
ENV CONDA_VER 4.1.11
ENV CONTINUUM_REPO https://repo.continuum.io/

ENV CONDA_LINK $CONTINUUM_REPO/miniconda/Miniconda3-${CONDA_VER}-Linux-x86_64.sh
ENV INSTALL_SCRIPT /tmp/conda.sh

RUN echo $CONDA_LINK
RUN curl -k -o $INSTALL_SCRIPT $CONDA_LINK \
    && /bin/bash $INSTALL_SCRIPT -f -b -p $CONDA_DIR \
    && rm $INSTALL_SCRIPT \
    && echo "installing" \
    && conda install --quiet --yes \
        jupyter pip \
        pandas scipy matplotlib cython numba seaborn \
    && conda remove -y nbpresent \
    && conda install -y -c damianavila82 rise \
    && conda install -y -c pydy version_information \
    && conda clean -y --all
ENV PATH $CONDA_DIR/bin:$PATH

############################################
## Python normal libs
RUN pip install --upgrade --no-cache-dir pip \
    # xls files
    xlrd openpyxl \
    # cool shell than works on top of ipython
    ptpython \
    # cool sql tool for notebook
    ipython-sql \
    # # launch R inside the notebook
    # rpy2 \
    # cool nosql database with joins, changefeeds and chaining
    rethinkdb \
    # https://glyph.twistedmatrix.com/2016/08/attrs.html
    attrs \
    # http://j.mp/lesser_known_libraries
    flit colorama begins \
    pywebview \
    watchdog ptpython \
    arrow parsedatetime timestring \
    # psutil \ # does not work
    boltons

############################################
## add user
ENV NB_USER jovyan
ENV NB_UID 1000

# Create jovyan user with UID=1000 and in the 'users' group
RUN adduser -s $SHELL -u $NB_UID $NB_USER -D && \
    mkdir -p $CONDA_DIR && \
    chown $NB_USER $CONDA_DIR

USER jovyan

# Setup jovyan home directory
RUN mkdir /home/$NB_USER/work && \
    mkdir /home/$NB_USER/.jupyter && \
    mkdir /home/$NB_USER/.local && \
    echo "cacert=/etc/ssl/certs/ca-certificates.crt" > /home/$NB_USER/.curlrc
COPY notebook_config.py /home/$NB_USER/.jupyter/jupyter_notebook_config.py

# Personal keybindings
RUN cd /opt/conda/share/jupyter/nbextensions/rise \
    && wget -q http://j.mp/risecustomkeys -O main.js

# Fix matplotlib?
RUN rm -rf ~/.cache/matplotlib ~/.matplotlib/fontList.cache ~/.cache/fontconfig

# Set executables for this user
RUN echo "export PATH=$CONDA_DIR/bin:/home/$NB_USER/.local/bin:\$PATH" > /home/$NB_USER/.bashrc


######################################
### tini as principal process ###
USER root

# jupyter kernel dies if you don't launch jupyter from inside a script
# https://github.com/ipython/ipython/issues/7062#issuecomment-223809024

ENV BOOTER /docker-entrypoint.sh
# https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#/entrypoint
ENV DATADIR /data
VOLUME $DATADIR
WORKDIR $DATADIR
ADD bootstrap.sh /docker-entrypoint.sh
RUN chmod +x $BOOTER
RUN chown $NB_USER -R $DATADIR

# WORKAROUND: tini
ENTRYPOINT ["/sbin/tini"]
CMD ["/docker-entrypoint.sh"]
